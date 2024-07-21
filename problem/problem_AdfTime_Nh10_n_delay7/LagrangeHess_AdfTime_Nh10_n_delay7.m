function LHess = LagrangeHess_AdfTime_Nh10_n_delay7(decVars, probParamsObjective, probParamsConstr, lambda)
    %{
        Function: LagrangeHess_AdfTime_Nh10_n_delay7
            ソルバーのタイプは，AdfTime
        Arguments: 
             decVars    : 決定変数
             probParamsObjective : 目的関数へのパラメータ
             probParamsConstr : 制約へのパラメータ
             lambda     : ラグランジュ乗数
    %}

    varsObjective = [decVars; probParamsObjective];
    varsConstr    = [decVars; probParamsConstr];


    objectiveHess = objectiveHess_AdfTime_Nh10_n_delay7(varsObjective);

    % Add the Lagrange multipliers * the constraint Hessians
    LHess = objectiveHess;
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_1(varsConstr) * lambda.ineqnonlin(1);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_2(varsConstr) * lambda.ineqnonlin(2);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_3(varsConstr) * lambda.ineqnonlin(3);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_4(varsConstr) * lambda.ineqnonlin(4);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_5(varsConstr) * lambda.ineqnonlin(5);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_6(varsConstr) * lambda.ineqnonlin(6);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_7(varsConstr) * lambda.ineqnonlin(7);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_8(varsConstr) * lambda.ineqnonlin(8);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_9(varsConstr) * lambda.ineqnonlin(9);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_10(varsConstr) * lambda.ineqnonlin(10);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_11(varsConstr) * lambda.ineqnonlin(11);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_12(varsConstr) * lambda.ineqnonlin(12);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_13(varsConstr) * lambda.ineqnonlin(13);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_14(varsConstr) * lambda.ineqnonlin(14);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_15(varsConstr) * lambda.ineqnonlin(15);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_16(varsConstr) * lambda.ineqnonlin(16);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_17(varsConstr) * lambda.ineqnonlin(17);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_18(varsConstr) * lambda.ineqnonlin(18);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_19(varsConstr) * lambda.ineqnonlin(19);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_20(varsConstr) * lambda.ineqnonlin(20);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_21(varsConstr) * lambda.ineqnonlin(21);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_22(varsConstr) * lambda.ineqnonlin(22);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_23(varsConstr) * lambda.ineqnonlin(23);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_24(varsConstr) * lambda.ineqnonlin(24);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_25(varsConstr) * lambda.ineqnonlin(25);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_26(varsConstr) * lambda.ineqnonlin(26);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_27(varsConstr) * lambda.ineqnonlin(27);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_28(varsConstr) * lambda.ineqnonlin(28);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_29(varsConstr) * lambda.ineqnonlin(29);
    LHess = LHess + constraintHess_AdfTime_Nh10_n_delay7_30(varsConstr) * lambda.ineqnonlin(30);

end
