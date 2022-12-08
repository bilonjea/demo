pgrep -lf demo
ps -fux | grep "demo"
kill -9 pid 

java -jar target/demo-*.jar

curl http://localhost:8080/explorer/index.html


1)
pid=$(pgrep -lf java | cut -d ' ' -f 1)
kill -9 $pid

java -jar target/demo-0.0.1-SNAPSHOT.jar & echo $! > demo.pid
pid=$(cat demo.pid)
kill -9 $pid

2)

sh -c 'echo $$; exec java -jar target/demo-0.0.1-SNAPSHOT.jar'

netstat ntaup
https://serverfault.com/questions/205498/how-to-get-pid-of-just-started-process


