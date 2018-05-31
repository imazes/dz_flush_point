#/bin/bash

Cur_Dir=$(cd `dirname $0`; pwd)
cd $Cur_Dir

username=$1;
password=$2;
times=$3

function random()
{
    min=$1;
    max=$2-$1;
    num=$(date +%s%N);
    ((retnum=num%max+min));
    echo $retnum;
}

function login(){
curl -s \
-c hostloc.cookie \
--user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' \
--form-string "username=$username" \
--form-string "password=$password" \
--form-string 'loginfield:=username' \
--form-string 'referer=http://www.hostloc.com/forum.php' \
"http://www.hostloc.com/member.php?mod=logging&action=login&loginsubmit=yes&infloat=yes&lssubmit=yes&inajax=1"
}

function visit_user(){
curl -s \
-b hostloc.cookie \
--user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' \
--form-string 'referer=http://www.hostloc.com/forum.php' \
"$1"
}


function get_points(){
echo $(curl -s -b hostloc.cookie http://www.hostloc.com/forum.php|grep -o '积分: [0-9]*'|grep -o '[0-9]*')
}

function brush_points(){
for(( i = 0; i < times ; i ++ ))
do 
    radm=$(random 1 10000);
    radm_url="http://www.hostloc.com/space-uid-$radm.html";
    echo "随机访问空间 $radm_url";
    visit_user $radm_url >/dev/null 2>&1;
    
done;
}


function main(){

login >/dev/null 2>&1;

points_before=$(get_points);
echo '原始积分为:'$points_before;

brush_points ;

points_after=$(get_points);
echo '最终积分为:'$points_after

archive_point=$((points_after - points_before));
echo "本次获得 $archive_point 分"
}

main;
rm hostloc.cookie;

