function LHess = LagrangeHess_AdfTime_Nh10_n_delay1(decVars, probParamsObjective, probParamsConstr, lambda)
    %{
        Function: LagrangeHess_AdfTime_Nh10_n_delay1
            ソルバーのタイプは，AdfTime
        Arguments: 
             decVars    : 決定変数
             probParamsObjective : 目的関数へのパラメータ
             probParamsConstr : 制約へのパラメータ
             lambda     : ラグランジュ乗数
    %}

    varsObjective = [decVars; probParamsObjective];
    varsConstr    = [decVars; probParamsConstr];


    objectiveHess = objectiveHess_AdfTime_Nh10_n_delay1(varsObjective);

    % Add the Lagrange multipliers * the constraint Hessians
    LHess = objectiveHess;
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_1(varsConstr) * lambda.ineqnonlin(1);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_2(varsConstr) * lambda.ineqnonlin(2);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_3(varsConstr) * lambda.ineqnonlin(3);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_4(varsConstr) * lambda.ineqnonlin(4);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_5(varsConstr) * lambda.ineqnonlin(5);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_6(varsConstr) * lambda.ineqnonlin(6);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_7(varsConstr) * lambda.ineqnonlin(7);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_8(varsConstr) * lambda.ineqnonlin(8);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_9(varsConstr) * lambda.ineqnonlin(9);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_10(varsConstr) * lambda.ineqnonlin(10);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_11(varsConstr) * lambda.ineqnonlin(11);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_12(varsConstr) * lambda.ineqnonlin(12);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_13(varsConstr) * lambda.ineqnonlin(13);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_14(varsConstr) * lambda.ineqnonlin(14);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_15(varsConstr) * lambda.ineqnonlin(15);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_16(varsConstr) * lambda.ineqnonlin(16);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_17(varsConstr) * lambda.ineqnonlin(17);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_18(varsConstr) * lambda.ineqnonlin(18);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_19(varsConstr) * lambda.ineqnonlin(19);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_20(varsConstr) * lambda.ineqnonlin(20);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_21(varsConstr) * lambda.ineqnonlin(21);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_22(varsConstr) * lambda.ineqnonlin(22);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_23(varsConstr) * lambda.ineqnonlin(23);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_24(varsConstr) * lambda.ineqnonlin(24);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_25(varsConstr) * lambda.ineqnonlin(25);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_26(varsConstr) * lambda.ineqnonlin(26);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_27(varsConstr) * lambda.ineqnonlin(27);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_28(varsConstr) * lambda.ineqnonlin(28);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_29(varsConstr) * lambda.ineqnonlin(29);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay1_30(varsConstr) * lambda.ineqnonlin(30);

end
