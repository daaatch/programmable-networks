from device_info import ios_xe1
from ncclient import manager

if __name__ == '__main__':
    print(f"Connecting to IOS-XR (!) at {ios_xe1['address']}...")
    with manager.connect(host=ios_xe1["address"],
                         port=ios_xe1["port"],
                         username=ios_xe1["username"],
                         password=ios_xe1["password"],
                         hostkey_verify=False) as m:

        print("Here are the NETCONF Capabilities:")
        # print all the Cisco-IOS-XR models supported
        for capability in m.server_capabilities:
            print(capability)
