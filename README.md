# TEI Support

Support assistant to TEI's users.

## Crontab execution

Edit the crontab file with ```crontab -e``` and add:

```
*/15    08-17        *     * *     sh /root/support.sh
0          18        *     * *     sh /root/disconnect.sh
```

###### By Ubiot
