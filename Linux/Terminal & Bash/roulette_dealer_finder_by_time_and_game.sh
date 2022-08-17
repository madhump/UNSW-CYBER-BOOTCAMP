#!/bin/bash

if [ $4 = 'Blackjack' ];

then

        awk '{print $1, $2, $5 ,$6}' $1_Dealer_schedule | grep $2:00:00 | grep $3M

elif [ $4 = 'Roulette' ];

then

        awk '{print $1, $2, $3, $4}'  $1_Dealer_schedule | grep $2:00:00 | grep $3M

elif [ $4 = 'Poker' ];

then

        awk '{print $1, $2, $7, $8}'  $1_Dealer_schedule | grep $2:00:00 | grep $3M

fi
