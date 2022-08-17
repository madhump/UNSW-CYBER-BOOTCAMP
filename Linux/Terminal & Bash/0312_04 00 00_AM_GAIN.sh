#!/bin/bash

awk '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep "04:00:00 AM"
