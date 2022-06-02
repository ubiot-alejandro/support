# TEI Support

Support assistant to TEI's users.

## Crontab execution

Edit the crontab file with ```crontab -e``` and add:

```
*/30    08-17        *     * *     sh /root/support.sh >> logs.txt
0          18        *     * *     sh /root/disconnect.sh >> logs.txt
```

###### By Ubiot
