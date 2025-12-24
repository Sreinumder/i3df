#!/bin/bash

weekday=$(date +%a)
date=$(date '+%y/%m/%d')
case $weekday in
  "Sun")
    wd="日"
    ;;
  "Mon")
    wd="月"
    ;;
  "Tue")
    wd="火"
    ;;
  "Wed")
    wd="水"
    ;;
  "Thu")
    wd="木"
    ;;
  "Fri")
    wd="金"
    ;;
  "Sat")
    wd="土"
  ;;
esac

echo "$date$wd"
