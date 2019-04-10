echo "+---------------------------------------------------------------------------------------------+"  
echo "|     ./ftail.sh xxxx.log | grep ERROR -A 30 -B 30            to monitor debug log            |" >&2  
echo "+---------------------------------------------------------------------------------------------+"  
echo  
if [ "$#" != "1" ]; then  
    echo "usage: $0 <file>" >&2  
    exit 1  
fi  
FILE="$1"  
INODE=$(stat -c "%i" "$FILE")  
fork_tail()  
{  
    if [ -r "$FILE" ]; then  
        tail -f "$FILE" &  
        PID=$!  
#        echo "##### $0: FILE $FILE INODE=$INODE PID $PID #####" >&2  
    else  
        PID=  
        INODE=  
#        echo "##### $0: FILE $FILE NOT FOUND #####" >&2  
    fi  
}  
kill_tail()  
{  
    if [ "$PID" ]; then  
        kill $PID  
    fi  
}  
inode_changed()  
{  
    NEW_INODE=$(stat -c "%i" "$FILE" 2>/dev/null)  
    if [ "$INODE" == "$NEW_INODE" ]; then  
        return 1  
    else  
        INODE=$NEW_INODE  
    fi  
}  
trap "kill_tail; exit" SIGINT SIGTERM SIGQUIT EXIT  
fork_tail  
while :  
do  
    sleep 5  
    if inode_changed; then  
        kill_tail  
        fork_tail  
    fi  
done  
