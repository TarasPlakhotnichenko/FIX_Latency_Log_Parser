#!/bin/bash
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs micex                       MICEX D sellside 1 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs micex_order_cancel_request  MICEX F sellside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs sets                        SETS  D sellside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs forts                       FORTS D sellside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs forts_order_cancel_request  FORTS F sellside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs nyse                        NYSE  D sellside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_35_micex                 MICEX D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_35_forts                 FORTS D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_35_xetra                 XETRA D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_35_sets                  SETS  D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_86_micex                 MICEX D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_86_forts                 FORTS D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_86_sets                  SETS  D buyside 0 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs qf_69_micex                 MICEX D buyside 0 1

#/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs nyse_client_id_CI0062     NYSE D sellside 0 0
#/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs forts_client_id_CI0062    FORTS D sellside 0 0
#/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs micex_client_id_CI0062    MICEX D sellside 0 0
#/usr/local/fix_stats/fix_stats.pl 192.168.215.77 /var/app/bridge/logs sets_client_id_CI0062     SETS D sellside 0 0


/usr/local/fix_stats/fix_stats.pl 192.168.215.83 /var/bridge/logs micex                           MICEX D sellside 1 0
/usr/local/fix_stats/fix_stats.pl 192.168.215.83 /var/bridge/logs forts                           FORTS D sellside 0 1

/usr/local/fix_stats/fix_stats.pl 10.230.48.43 /var/bridge/logs micex                             MICEX D sellside 1 0
/usr/local/fix_stats/fix_stats.pl 10.230.48.43 /var/bridge/logs forts                             FORTS D sellside 0 1

/usr/local/fix_stats/fix_stats.pl 10.230.48.44 /var/app/bridge/logs micex                         MICEX D sellside 1 0
/usr/local/fix_stats/fix_stats.pl 10.230.48.44 /var/app/bridge/logs sets                          SETS  D sellside 0 0
/usr/local/fix_stats/fix_stats.pl 10.230.48.44 /var/app/bridge/logs sets_order_cancel_request     SETS  F sellside 0 0
/usr/local/fix_stats/fix_stats.pl 10.230.48.44 /var/app/bridge/logs forts                         FORTS D sellside 0 1


