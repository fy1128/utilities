#/bin/bash
large=`grep -Pzoa '(?s)\nTEL[^\n]+' large.vcf|sed -e $'s/[^0-9\ ]*//g'|sed -e $'s/\ //g'`

little=`grep -Pzoa '(?s)\nTEL[^\n]+' little.vcf|sed -e $'s/[^0-9\ ]*//g'|sed -e $'s/\ //g'`
#echo "${large}" |while read line
#do
    #echo -e $((i++))"正在查找 $line\n"
#    record=`echo ${little}|grep "${line}"`
#    [ $? -eq 1 ] && echo $line
#done
arg=(-vlittle="$(echo $little)")
awk "${arg[@]}" 'BEGIN{ record=""} {
    split($0, large_arr, " ")
    split(little, little_arr, " ")
    print length(large_arr) " > " length(little_arr)
    print "#####################"
    for (item in little_arr) {
        little_arr_reindex[little_arr[item]] = little_arr[item]
    }
    for (i=1; i <= length(large_arr); i++) {

        if (large_arr[i] in little_arr_reindex) {
            continue
        } else {
            print large_arr[i]
        }
    }
    print "#####################"
}' <<< $large