function LHess = LagrangeHess_AdfTime_Nh5_n_delay2(decVars, probParamsObjective, probParamsConstr, lambda)
    %{
        Function: LagrangeHess_AdfTime_Nh5_n_delay2
            ソルバーのタイプは，AdfTime
        Arguments: 
             decVars    : 決定変数
             probParamsObjective : 目的関数へのパラメータ
             probParamsConstr : 制約へのパラメータ
             lambda     : ラグランジュ乗数
    %}

    varsObjective = [decVars; probParamsObjective];
    varsConstr    = [decVars; probParamsConstr];


    objectiveHess = objectiveHess_AdfTime_Nh5_n_delay2(varsObjective);

    % Add the Lagrange multipliers * the constraint Hessians
    LHess = objectiveHess;
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_1(varsConstr) * lambda.ineqnonlin(1);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_2(varsConstr) * lambda.ineqnonlin(2);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_3(varsConstr) * lambda.ineqnonlin(3);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_4(varsConstr) * lambda.ineqnonlin(4);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_5(varsConstr) * lambda.ineqnonlin(5);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_6(varsConstr) * lambda.ineqnonlin(6);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_7(varsConstr) * lambda.ineqnonlin(7);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_8(varsConstr) * lambda.ineqnonlin(8);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_9(varsConstr) * lambda.ineqnonlin(9);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_10(varsConstr) * lambda.ineqnonlin(10);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_11(varsConstr) * lambda.ineqnonlin(11);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_12(varsConstr) * lambda.ineqnonlin(12);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_13(varsConstr) * lambda.ineqnonlin(13);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_14(varsConstr) * lambda.ineqnonlin(14);
    LHess = LHess + constraintHess_AdfTime_Nh5_n_delay2_15(varsConstr) * lambda.ineqnonlin(15);

end
