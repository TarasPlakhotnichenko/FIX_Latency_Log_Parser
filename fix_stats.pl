#!/usr/bin/perl
#example: /usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs micex buyside 1 1

use strict;
use warnings;
unless ($#ARGV == 7) { print("usage:\t./fix_stats.pl <remote ip> <remote path> <condition> <market> <type: D | F | G> <buyside flag: buyside or sellside> <copy remote log flag: 1  0> <delete local file: 1 0>\n"); exit(1);}
my $date_current=`date +%Y%m%d`;
my $FIXOUTTIME=0;
my $FIXINTIME=0;
my $CUR_POSITION=0;
my $line;
my $TRADE_ID;
my @ak_line;
my @trade;
my $val='';
my $trade_time='';
my $flag_ak=0;
my $flag_new_order=0;
my $delay=0;
my @time;
my $date_yesterday=`date +%Y%m%d --date="yesterday"`;
#my $date_2days_ago=`date +%Y%m%d --date="2 days ago"`;

chomp($date_yesterday);
chomp($ARGV[0]);
chomp($ARGV[1]);
chomp($ARGV[2]);
chomp($ARGV[3]);
chomp($ARGV[4]);
chomp($ARGV[5]);
chomp($ARGV[6]);
chomp($ARGV[7]);

my $remote_ip=$ARGV[0];
my $remote_path=$ARGV[1];
my $condition=$ARGV[2];
my $market=$ARGV[3];
my $order_type=$ARGV[4];
my $sell_buy=$ARGV[5];
my $scp_flag=$ARGV[6];
my $del_flag=$ARGV[7];

my @all=();


my $temp_file0="/root/DEV/fix_stats/tmp0.log";
my $temp_file1="/root/DEV/fix_stats/tmp1.log";
my $temp_file2="/root/DEV/fix_stats/tmp2.log";
#-------------------------------vvv
my $remote_file="$date_yesterday\.txt";

#-------------------------------^^^


#-------------------------------vvv
my $local_file="$date_yesterday\.txt";
#my $local_file="20120710.txt";
#-------------------------------^^^

my $local_path="/usr/local/fix_stats";
my $out="/usr/local/fix_stats/delays.txt";

#-----BuySide or SellSide-----------------vvv
my $sell_buy_str1='';
my $sell_buy_str2='';
if ($sell_buy eq 'sellside')
{
$sell_buy_str1='Receiving:';
$sell_buy_str2='Sending:';
}
elsif ($sell_buy eq 'buyside')
{
$sell_buy_str1='Sending:';
$sell_buy_str2='Receiving:';
}
#-----BuySide or SellSide-----------------^^^



#------FIX tags---------------------------vvv
my $tag35='';
my $tag39='';

if ($order_type eq "D")
{
 $tag35="35\=D";
 $tag39="39\=0";
} elsif ($order_type eq "F")
{
 $tag35="35\=F";
 $tag39="39\=4";
}
 elsif ($order_type eq "G")
{
 $tag35="35\=G";
 $tag39="39\=5";
}
#------FIX tags---------------------------^^^


#copy log file from remote host and  rename it---------------------------------------vvv

if ($scp_flag == 1) {
print "Removing old archive file from $local_path...\n";
`rm "$local_path"/20*\_"$remote_ip"\.tar\.gz`;


print "Removing old .txt file from $local_path...\n";
`rm "$local_path"/20*\.txt`;

print "Copying file from remote host $remote_path/$remote_file...\n";
#`scp  root\@$remote_ip:$remote_path/$remote_file $local_path/$local_file`;
`ssh root\@$remote_ip \"(cd "$remote_path"; tar -zcvf - "$remote_file")\" > "$local_path"/"$date_yesterday"\_"$remote_ip"\.tar\.gz`;


`/bin/tar -xzf "$local_path"/"$date_yesterday"\_"$remote_ip"\.tar\.gz -C "$local_path"`;


}

#copy log file from remote host and  rename it---------------------------------------^^^

print "Processing... stage 1\n";  
if (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'micex'))

  #----192.168.215.77-----------------------------------------------------------------vvv
  {
  #my $command = "/bin/sed  -e '/\\[QF_69\\]/b'  -e d "$local_path/$local_file" > $temp_file1";
  #system("$command");
  
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'micex_order_cancel_request') and ("$order_type" eq 'F'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=F/b' -e  '/39=4/b' -e d "$temp_file1"  > $temp_file2`;
  }
  
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'sets'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'forts'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  
  
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'forts_order_cancel_request') and ("$order_type" eq 'F'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=F/b' -e  '/39=4/b' -e d "$temp_file1"  > $temp_file2`;
  }
    
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'nyse'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  
  #----client------------------------vvv
  #elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'micex_client_id_CI0062'))
  #{
  # `sed -n '/\\[Infina_Orders\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$temp_file0" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  
  #elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'sets_client_id_CI0062'))
  #{
  # `sed -n '/\\[Infina_Orders\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$temp_file0" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  
  #elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'forts_client_id_CI0062'))
  #{
  # `sed -n '/\\[Infina_Orders\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$temp_file0" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  
  #elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'nyse_client_id_CI0062'))
  #{
  # `sed -n '/\\[Infina_Orders\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$temp_file0" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
 
  #----client------------------------^^^
  
  
  #----qf_35------------------------vvv  
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_35_micex'))
  {
   `sed -n '/\\[QF_35\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/MICEX/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_35_forts'))
  {
   `sed -n '/\\[QF_35\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/FORTS/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_35_xetra'))
  {
   `sed -n '/\\[QF_35\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/XETRA/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_35_sets'))
  {
   
   `sed -n '/\\[QF_35\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/SETS/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  #----qf_35------------------------^^^
  
  #----qf_86------------------------vvv
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_86_micex'))
  {
   `sed -n '/\\[QF_86\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/MICEX/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_86_forts'))
  {
   `sed -n '/\\[QF_86\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/FORTS/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_86_sets'))
  {
   `sed -n '/\\[QF_86\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/SETS/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  #----qf_86------------------------^^^
  
  #----qf_69------------------------vvv
  elsif (("$remote_ip" eq '192.168.215.77') and ("$condition" eq 'qf_69_micex'))
  {
   `sed -n '/\\[QF_69\\]/p'  "$local_path"/"$local_file" > "$temp_file0"`;
   `sed -n '/MICEX/p'  "$temp_file0" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  
  #----qf_69------------------------^^^
   
  
  #----192.168.215.77-----------------------------------------------------------------^^^
  
  
  #----10.230.48.44-------------------------------------------------------------------vvv
  elsif (("$remote_ip" eq '10.230.48.44') and ("$condition" eq 'micex'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '10.230.48.44') and ("$condition" eq 'forts'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '10.230.48.44') and ("$condition" eq 'sets_order_cancel_request') and  ("$order_type" eq 'F'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=F/b' -e  '/39=4/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '10.230.48.44') and ("$condition" eq 'sets'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  #----10.230.48.44-------------------------------------------------------------------^^^
  
  #----10.230.48.43-------------------------------------------------------------------vvv
  elsif (("$remote_ip" eq '10.230.48.43') and ("$condition" eq 'micex'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '10.230.48.43') and ("$condition" eq 'forts'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  #----10.230.48.43-------------------------------------------------------------------^^^
  
  #----192.168.215.83-------------------------------------------------------------------vvv
  elsif (("$remote_ip" eq '192.168.215.83') and ("$condition" eq 'micex'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  elsif (("$remote_ip" eq '192.168.215.83') and ("$condition" eq 'forts'))
  {
   `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
   `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  }
  #----192.168.215.83-------------------------------------------------------------------^^^
  
  
  #----192.168.215.85-------------------------------------------------------------------vvv
  #elsif (("$remote_ip" eq '192.168.215.85') and ("$condition" eq 'micex'))
  #{
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  #elsif (("$remote_ip" eq '192.168.215.85') and ("$condition" eq 'forts'))
  #{
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  #elsif (("$remote_ip" eq '192.168.215.85') and ("$condition" eq 'sets'))
  #{
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  #----192.168.215.85-------------------------------------------------------------------^^^
   
  
  #----10.48.48.25-------------------------------------------------------------------vvv
  #elsif (("$remote_ip" eq '10.48.48.25') and ("$condition" eq 'micex'))
  #{
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  #elsif (("$remote_ip" eq '10.48.48.25') and ("$condition" eq 'forts'))
  #{
  # `sed -e '/Sending:/b' -e  '/Receiving:/b' -e d  "$local_path/$local_file" > "$temp_file1"`;
  # `sed -e '/35=D/b' -e  '/39=0/b' -e d "$temp_file1"  > $temp_file2`;
  #}
  #----10.48.48.25-------------------------------------------------------------------^^^
  
  
  else
  {
  print "Stays out of condition\n";
  exit;
  }

#---------------------------processing------------------------------------------------vvv
print "Processing... stage 2\n";  
open (OUT, ">$out");
open(IN, "<", "$temp_file2") or die "can't open $temp_file2: $!\n";
while($line = <IN>)
{
 $flag_new_order=0;
 if (($line=~m/$tag35/i) and ($line=~m/$sell_buy_str1/i) and ($line=~m/$market/i))
  {
   @trade=split('\|', $line);
#--------------Exctract Trade Unique ID----------vvv
     foreach  $val (@trade) {
       if ($val=~m/^11\=/i)
       {
        $val =~ s/11\=//;
        chomp($val);
        $TRADE_ID = $val;
       }
      }
#--------------Exctract Trade Unique ID----------^^^

#--------------Exctract Trade Time---------------vvv
  #15:51:12.483_22810
  @trade=split(' ', $line);
  $trade_time = $trade[1];
  $trade[1] = substr $trade[1],0, 12;
  $trade[1]  =~ s/\./:/;
  @time=split(':', $trade[1]);
  $FIXINTIME = ($time[0] * 3600000) + ($time[1] * 60000) + ($time[2] * 1000) + $time[3];
  
  #GNUPLOT--------------vvv
  $trade_time = substr $trade_time,0, 8;
  $trade_time  =~ s/://;
  $trade_time  =~ s/://;
  #print "$trade_time ";
  #GNUPLOT--------------^^^

#--------------Exctract Trade Time---------------^^^
  $flag_new_order=1;
 }
else
{
 $flag_new_order=0;
}

if ($flag_new_order==1)
{
#START FOR
$flag_ak=0;
$CUR_POSITION=tell(IN);

#--for cycle--------------------vvv
for (my $i=0;$i<40;$i++)
{
if ($line = <IN>)
 {
  if (($line=~m/11\=$TRADE_ID\b/) and ($line=~m/$tag39/) and ($flag_new_order==1) and ($line=~m/$sell_buy_str2/i))
    {
	
     #Exctract Trade Time--------------------vvv
     #15:51:12.483_22810
     @ak_line=split(' ', $line);
     $ak_line[1] = substr $ak_line[1], 0, 12;
     $ak_line[1] =~ s/\./:/;
     @time=split(':',$ak_line[1]);
     $FIXOUTTIME = ($time[0] * 3600000) + ($time[1] * 60000) + ($time[2] * 1000) + $time[3];
     #print " \n---$TRADE_ID   $tag39  $time[0]:$time[1]:$time[2].$time[3]--- \n";
     #Exctract Trade Time--------------------^^^
	 
     $flag_ak=1;
	 last;
    }
    else
    {
    $flag_ak=0;
    }
 }
 else
 {
  last;
 }
}
#--for cycle--------------------^^^

if ($flag_ak == 0)
{
  #print " fixout - zero \n"
}
else
{
$delay = $FIXOUTTIME -  $FIXINTIME; 
print  "$trade_time|$TRADE_ID|$FIXINTIME|$FIXOUTTIME|$delay"  . "\n";
print OUT "$trade_time|$TRADE_ID|$FIXINTIME|$FIXOUTTIME|$delay"  . "\n";


push(@all,[$trade_time,$TRADE_ID,$FIXINTIME,$FIXOUTTIME,$delay]);


}
seek(IN, $CUR_POSITION, 0);
}
}
close OUT;

# print @{$all[0]}[4];

my ($max, $min) = (-1e308, 1e308);
my $avrg=0;
my $count=0;
my $sum=0;
foreach (@all) {
    $max = @{$_}[4] if @{$_}[4] > $max;
    $min = @{$_}[4] if @{$_}[4] < $min;
	$sum=$sum+@{$_}[4];
	$count++;
}
$avrg=$sum/$count;

open (MESSAGE,">" ,"$local_path/message.txt");
print MESSAGE "FIX STATS: \ntime  | trade id | fix in time  ms | fix out time ms | latency\n\n";
print MESSAGE "Count: $count, Max: $max, Avarage: $avrg, Min: $min\n\n";
print MESSAGE "For more details: http://nagios.open.ru/twiki/bin/view/OSL/FixDelaysReport";



if ($del_flag == 1) {
print "Deleting file $local_path/$local_file...\n";
`rm "$local_path/$local_file"`;
}

#-------creating graph--------------------vvv
`"$local_path"/gnuplot.sh "$remote_ip"_"$condition"`;
#-------creating graph--------------------^^^



