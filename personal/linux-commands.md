## Copy file from personal computer to SSH:

```bash
scp -P <PORT> $HOME/<PATH_TO_LOCAL_FILE> <SERVER_USER>@<SERVER_IP_ADDRESS>:<DESTINATION_PATH>
```

## Get current port from SSH connection

```bash
echo #{SSH_CLIENT##* }
```
