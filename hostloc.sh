#/bin/bash

Cur_Dir=$(cd `dirname $0`; pwd)
cd $Cur_Dir

username=$1;
password=$2;
times=$3;
cookie_name=$username'.hostloc.cookie';
hostname='https://www.hostloc.com';
usa='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36';

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
-c "$cookie_name" \
--user-agent "$usa" \
--form-string "username=$username" \
--form-string "password=$password" \
--form-string 'loginfield:=username' \
--form-string "referer=$hostname/forum.php" \
"$hostname/member.php?mod=logging&action=login&loginsubmit=yes&infloat=yes&lssubmit=yes&inajax=1"
}

function visit_user(){
curl -s \
-b "$cookie_name" \
--user-agent "$usa" \
--form-string "referer=$hostname/forum.php" \
"$1"
}


function get_points(){
echo $(curl -s -b "$cookie_name" --user-agent  "$usa" "$hostname/home.php?mod=spacecp&ac=credit"|grep -o '积分: [0-9]*'|grep -o '[0-9]*')

}

function brush_points(){
for(( i = 0; i < times ; i ++ ))
do 
    radm=$(random 200 300);
    radm_url="$hostname/space-uid-$radm.html";
    echo "随机访问空间 $radm_url";
    visit_user $radm_url >/dev/null 2>&1;
    # visit_user $radm_url ;
    
done;
}


function main(){

points_before=$(get_points);

if [ $points_before'x' == 'x' ];then
echo 'coocie失效，重新登陆';
login >/dev/null 2>&1;
fi
points_before=$(get_points);
echo '原始积分为:'$points_before;


brush_points ;

points_after=$(get_points);
echo '最终积分为:'$points_after

archive_point=$((points_after - points_before));
echo "本次获得 $archive_point 分"
}

msg=$(main);
# rm "$cookie_name";
#/opt/src/sendmsg2Telegram "$msg"
 echo "$msg"
