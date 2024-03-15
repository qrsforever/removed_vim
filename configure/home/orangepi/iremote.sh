#!/system/bin/sh

# key  4  BACK
# key  19  DPAD_UP
# key  20  DPAD_DOWN
# key  21  DPAD_LEFT
# key  22  DPAD_RIGHT
# key  23  DPAD_CENTER
while true
do
    key=`getevent -c 1 /dev/input/event1 | cut -d\  -f3`
    case "$key" in
        "ed7ca00e")
            input keyevent 4
            ;;
        "ed7cd090")
            input keyevent 19
            ;;
        "ed7c0709")
            input keyevent 20
            ;;
        "ed7cb050")
            input keyevent 21
            ;;
        "ed7c0f01")
            input keyevent 22
            ;;
        "ed7c50d0")
            input keyevent 23
            ;;
    esac
done
