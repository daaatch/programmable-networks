import time
import xmltodict
from ncclient import manager

# list of devices to iterate through
devices = [
    {
        "name": "IOS-XR-Always-On-1",
        "address": "sandbox-iosxr-1.cisco.com",
        "port": 830,
        "username": "turno.1835365",
        "password": "4s4F_cB-o_gV5Aa"
    }
]

# periodic polling time in seconds
interval = 5

def monitor_tx_bytes():
    print("initializing netconf connections...")
    sessions = {}
    
    for dev in devices:
        try:
            m = manager.connect(
                host=dev["address"],
                port=dev["port"],
                username=dev["username"],
                password=dev["password"],
                hostkey_verify=False
            )
            sessions[dev["name"]] = m
            print(f" [+] connected to {dev['name']} ({dev['address']})")
        except Exception as e:
            print(f" [-] failed to connect to {dev['name']}: {e}")
            
    if not sessions:
        print("no active connections")
        return

    # leave <interface/> empty to pull all inner structures
    subtree_filter = """
    <filter>
      <infra-statistics xmlns="http://cisco.com/ns/yang/Cisco-IOS-XR-infra-statsd-oper">
        <interfaces>
          <interface/>
        </interfaces>
      </infra-statistics>
    </filter>
    """
        
    try:
        while True:
            print("=====================================================================")
            print(f"polling transmitted bytes at {time.strftime('%Y-%m-%d %H:%M:%S')}")
            for name, m in sessions.items():
                try:
                    netconf_reply = m.get(subtree_filter)
                    data = xmltodict.parse(netconf_reply.xml)
                    
                    infra_stats = data.get("rpc-reply", {}).get("data", {}).get("infra-statistics", {})
                    interfaces = infra_stats.get("interfaces", {}).get("interface", [])
                    
                    if isinstance(interfaces, dict):
                        interfaces = [interfaces]
                        
                    print(f"\nDevice: {name}")
                    if not interfaces:
                        print("  no matching interfaces found.")
                        
                    for intf in interfaces:
                        intf_name = intf.get("interface-name", "Unknown")
                        
                        if "GigE" in intf_name or "Ethernet" in intf_name:
                            tx_bytes = None
                            
                            # check common counter containers (latest/total/cache)
                            for container in ["latest", "total", "cache"]:
                                if container in intf:
                                    tx_bytes = intf[container].get("generic-counters", {}).get("bytes-sent")
                                    if tx_bytes is not None:
                                        break
                            
                            # check if the interface counters are uninitialized/zero 
                            if tx_bytes is None:
                                tx_bytes = "0 (No Traffic / Uninitialized)"
                                
                            print(f"  interface: {intf_name:<25} | transmitted bytes: {tx_bytes}")
                
                except Exception as e:
                    print(f"error querying {name}: {e}")
                    
            print("====================================================================")
            print(f"\nwaiting {interval} seconds before next poll...")
            time.sleep(interval)
        
    except KeyboardInterrupt:
        print("\nscript interrupted by user, shutting down gracefully...")
    finally:
        for name, m in sessions.items():
            print(f"closing session for {name}")
            m.close_session()

if __name__ == '__main__':
    monitor_tx_bytes()
