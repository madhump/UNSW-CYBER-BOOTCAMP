#!/bin/bash

awk '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep "02:00:00 PM"
