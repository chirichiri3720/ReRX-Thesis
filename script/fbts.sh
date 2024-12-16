#!/bin/bash

cd "$(dirname "$0")"
cd ../
source .venv/bin/activate
data=$1

echo $data
 
if [[ "$data" =~ ^[0-9]+$ ]]; then
    declare -A data_dict=(
        [40981]=australian
        [44096]=german
        [53]=heart
        [40715]=pima
        [50]=tic-tac
        [44]=spambase
        [1462]=banknote
        [1494]=biodeg
        [1558]=bank-marketing
        [45557]=mammographic
        [45562]=seismic
        [43]=haberman
        [41]=glass
        [46]=splice
        [23]=cmc
        [54]=vehicle
    )
    echo ${data_dict[$data]}
    python main.py hydra.sweep.dir=outputs/log/${data_dict[$data]}/fbts data=openml data.id=$data exp=optuna exp.study_name=${data_dict[$data]}-fbts-\${seed} model=fbts data.categorical_encoder=onehot seed='range(0,10)' -m
else
    python main.py hydra.sweep.dir=outputs/log/$data/fbts data.name=$data exp=optuna exp.study_name=${data}-fbts-\${seed} model=fbts data.categorical_encoder=onehot seed='range(0,10)' -m
fi

