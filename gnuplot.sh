#!/bin/bash
#cat /usr/local/fix_stats/simple.graph | /usr/bin/gnuplot
YESTERDAY=`date +%Y-%m-%d --date="-1 day"`;
/usr/bin/gnuplot <<-finis
#set terminal postscript eps enhanced
set terminal png nocrop enhanced  12 size 1200,768
set output "/usr/local/fix_stats/delays_$1.png"
set encoding koi8r
set xlabel "Time"
set ylabel "Delay"
#set xrange [111547:182959]
#set xtics 111547,60000
set xdata time
set timefmt "%H%M%S"
#set xtics auto
#set auto x
#set yrange [0:100]
#set ytics 0,50
set ytics auto
#set auto y
#set style line 1 lt 1 pt 1
set style line 1 lt 1 lw 1 pt 5 ps 0.65
set datafile separator "|"
plot "/usr/local/fix_stats/delays.txt" using 1:5 title "FIX DELAYS $YESTERDAY" with linespoints linestyle 1
finis

mutt -a /usr/local/fix_stats/delays.txt -a /usr/local/fix_stats/delays_"$1".png -s "FIX STATS. Report: $1" Tech_report@open.ru  < /usr/local/fix_stats/message.txt
#mutt -a /usr/local/fix_stats/delays.txt -a /usr/local/fix_stats/delays_"$1".png -s "FIX STATS. Report: $1" Taras.Plahotnichenko@otkritie.com  < /usr/local/fix_stats/message.txt
cp /usr/local/fix_stats/delays_"$1".png /var/www/html/twiki/pub/OSL/FixDelaysReport/delays_"$1".png

