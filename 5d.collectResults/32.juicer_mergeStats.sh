
paste *-juicerStats.txt | awk '{print $1,$7,$8,$2,$3,$4,$5}' OFS="\t" > $1

rm *-juicerStats.txt



