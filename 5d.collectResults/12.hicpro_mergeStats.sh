
paste *mapstat.txt | awk '{print $1,$7,$8,$2,$3,$4,$5}' OFS="\t" > mapstat.txt

rm *-mapstat.txt

paste *-mergestat.txt | awk '{print $1,$7,$8,$2,$3,$4,$5}' OFS="\t" > mergestat.txt

rm *-mergestat.txt

paste *pairstat.txt | awk '{print $1,$7,$8,$2,$3,$4,$5}' OFS="\t" > pairstat.txt

rm *-pairstat.txt

paste *RSstat.txt | awk '{print $1,$7,$8,$2,$3,$4,$5}' OFS="\t" > RSstat.txt

rm *-RSstat.txt


