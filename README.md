# TEI Support

Support assistant to TEI's users.

## Crontab execution

Edit the crontab file with ```crontab -e``` and add:

```
*/15    08-17        *     * *     sh support.sh
0          18        *     * *     sh disconnect.sh
```

###### By Ubiot
