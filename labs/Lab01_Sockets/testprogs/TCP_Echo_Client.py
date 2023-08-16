# TCP_Echo_Client.py
import sys, argparse
import socket

RECV_BUFFER_SIZE = 1024

# Get the server hostname and port as command line arguments
def get_args(argv):
    parser = argparse.ArgumentParser(description="TCP Echo Client")
    parser.add_argument('-p', '--port', required=False, default=12000, type=int)
    parser.add_argument('-a', '--address', required=True)
    return parser.parse_args()

def main(argv):
    args = get_args(argv)

    # Create TCP client socket (note use of SOCK_STREAM) 
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    
    # Connect socket to server
    client_socket.connect((args.address, args.port))

    # Get message from user
    message = input("Enter your message: ")
    
    # Send the message
    client_socket.send(message.encode())

    # Receive the server response
    reply = client_socket.recv(RECV_BUFFER_SIZE)  
    print("Received response\t{}".format(reply.decode()))

    # Close the client socket
    client_socket.close()
 
if __name__ == "__main__":
    main(sys.argv[1:])
