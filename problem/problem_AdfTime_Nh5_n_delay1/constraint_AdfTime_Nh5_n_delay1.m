function [c,ceq,gradc,gradceq] = constraint_AdfTime_Nh5_n_delay1(in1)
%CONSTRAINT_ADFTIME_NH5_N_DELAY1
%    [C,CEQ,GRADC,GRADCEQ] = CONSTRAINT_ADFTIME_NH5_N_DELAY1(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    18-Oct-2021 06:39:16

M1 = in1(1,:);
M2 = in1(2,:);
M3 = in1(3,:);
M4 = in1(4,:);
M5 = in1(5,:);
M6 = in1(6,:);
M7 = in1(7,:);
M8 = in1(8,:);
M9 = in1(9,:);
M10 = in1(10,:);
M11 = in1(11,:);
M12 = in1(12,:);
M13 = in1(13,:);
M14 = in1(14,:);
M15 = in1(15,:);
M16 = in1(16,:);
M17 = in1(17,:);
M18 = in1(18,:);
M19 = in1(19,:);
M20 = in1(20,:);
h1 = in1(21,:);
h2 = in1(22,:);
h3 = in1(23,:);
h4 = in1(24,:);
h5 = in1(25,:);
h_pre1 = in1(49,:);
x01 = in1(26,:);
x02 = in1(27,:);
x03 = in1(28,:);
t2 = abs(M1);
t3 = abs(M2);
t4 = abs(M3);
t5 = abs(M4);
t6 = abs(M5);
t7 = abs(M6);
t8 = abs(M7);
t9 = abs(M8);
t10 = abs(M9);
t11 = abs(M10);
t12 = abs(M11);
t13 = abs(M12);
t14 = abs(M13);
t15 = abs(M14);
t16 = abs(M15);
t17 = abs(M16);
t18 = abs(M17);
t19 = abs(M18);
t20 = abs(M19);
t21 = abs(M20);
t22 = sign(M1);
t23 = sign(M2);
t24 = sign(M3);
t25 = sign(M4);
t26 = sign(M5);
t27 = sign(M6);
t28 = sign(M7);
t29 = sign(M8);
t30 = sign(M9);
t31 = sign(M10);
t32 = sign(M11);
t33 = sign(M12);
t34 = sign(M13);
t35 = sign(M14);
t36 = sign(M15);
t37 = sign(M16);
t38 = sign(M17);
t39 = sign(M18);
t40 = sign(M19);
t41 = sign(M20);
t62 = M1.*(7.0./1.0e+2);
t63 = M2.*(7.0./1.0e+2);
t64 = M3.*(7.0./1.0e+2);
t65 = M4.*(7.0./1.0e+2);
t66 = M5.*(7.0./1.0e+2);
t67 = M6.*(7.0./1.0e+2);
t68 = M7.*(7.0./1.0e+2);
t69 = M8.*(7.0./1.0e+2);
t70 = M9.*(7.0./1.0e+2);
t71 = M10.*(7.0./1.0e+2);
t72 = M11.*(7.0./1.0e+2);
t73 = M12.*(7.0./1.0e+2);
t74 = M13.*(7.0./1.0e+2);
t75 = M14.*(7.0./1.0e+2);
t76 = M15.*(7.0./1.0e+2);
t77 = M16.*(7.0./1.0e+2);
t78 = M17.*(7.0./1.0e+2);
t79 = M18.*(7.0./1.0e+2);
t80 = M19.*(7.0./1.0e+2);
t81 = M20.*(7.0./1.0e+2);
t92 = M1.*6.018440000000001e-2;
t93 = M2.*6.018440000000001e-2;
t94 = M3.*6.018440000000001e-2;
t95 = M4.*6.018440000000001e-2;
t96 = M5.*6.018440000000001e-2;
t97 = M6.*6.018440000000001e-2;
t98 = M7.*6.018440000000001e-2;
t99 = M8.*6.018440000000001e-2;
t100 = M9.*6.018440000000001e-2;
t101 = M10.*6.018440000000001e-2;
t102 = M11.*6.018440000000001e-2;
t103 = M12.*6.018440000000001e-2;
t104 = M1.*5.269815726e-2;
t105 = M2.*5.269815726e-2;
t106 = M3.*5.269815726e-2;
t107 = M4.*5.269815726e-2;
t108 = M5.*5.269815726e-2;
t109 = M6.*5.269815726e-2;
t110 = M1.*4.6896232582842e-2;
t111 = M2.*4.6896232582842e-2;
t42 = t2.^2;
t43 = t3.^2;
t44 = t4.^2;
t45 = t5.^2;
t46 = t6.^2;
t47 = t7.^2;
t48 = t8.^2;
t49 = t9.^2;
t50 = t10.^2;
t51 = t11.^2;
t52 = t12.^2;
t53 = t13.^2;
t54 = t14.^2;
t55 = t15.^2;
t56 = t16.^2;
t57 = t17.^2;
t58 = t18.^2;
t59 = t19.^2;
t60 = t20.^2;
t61 = t21.^2;
t114 = t62+4.745173e-1;
t115 = t66+4.745173e-1;
t116 = t72+4.745173e-1;
t117 = t80+4.745173e-1;
t122 = t63+1.23107e-2;
t123 = t67+1.23107e-2;
t124 = t73+1.23107e-2;
t125 = t81+1.23107e-2;
t162 = t64+t92+5.112942700500001e-1;
t163 = t70+t96+5.112942700500001e-1;
t164 = t78+t102+5.112942700500001e-1;
t174 = t65+t93+1.100872177e-2;
t175 = t71+t97+1.100872177e-2;
t176 = t79+t103+1.100872177e-2;
t186 = t68+t94+t104+5.237769775973601e-1;
t187 = t76+t100+t108+5.237769775973601e-1;
t192 = t69+t95+t105+9.985843755069999e-3;
t193 = t77+t101+t109+9.985843755069999e-3;
t202 = t75+t99+t107+t111+9.16553375393378e-3;
t203 = t74+t98+t106+t110+5.209861593273429e-1;
t82 = t42+t43;
t85 = t44+t45+t46+t47;
t88 = t48+t49+t50+t51+t52+t53;
t91 = t54+t55+t56+t57+t58+t59+t60+t61;
t118 = abs(t114);
t119 = abs(t115);
t120 = abs(t116);
t121 = abs(t117);
t130 = abs(t122);
t131 = abs(t123);
t132 = abs(t124);
t133 = abs(t125);
t165 = abs(t162);
t166 = abs(t163);
t167 = abs(t164);
t168 = sign(t162);
t169 = sign(t163);
t170 = sign(t164);
t177 = abs(t174);
t178 = abs(t175);
t179 = abs(t176);
t180 = sign(t174);
t181 = sign(t175);
t182 = sign(t176);
t188 = abs(t186);
t189 = abs(t187);
t190 = sign(t186);
t191 = sign(t187);
t194 = abs(t192);
t195 = abs(t193);
t198 = sign(t192);
t199 = sign(t193);
t204 = abs(t202);
t205 = sign(t202);
t206 = abs(t203);
t207 = sign(t203);
t83 = sqrt(t82);
t86 = sqrt(t85);
t89 = sqrt(t88);
t112 = sqrt(t91);
t126 = t118.^2;
t127 = t119.^2;
t128 = t120.^2;
t129 = t121.^2;
t135 = t130.^2;
t136 = t131.^2;
t137 = t132.^2;
t138 = t133.^2;
t171 = t165.^2;
t172 = t166.^2;
t173 = t167.^2;
t183 = t177.^2;
t184 = t178.^2;
t185 = t179.^2;
t196 = t188.^2;
t197 = t189.^2;
t200 = t194.^2;
t201 = t195.^2;
t208 = t204.^2;
t209 = t206.^2;
t84 = 1.0./t83;
t87 = 1.0./t86;
t90 = 1.0./t89;
t113 = 1.0./t112;
t134 = t83.*3.090232306167814;
t141 = t86.*3.090232306167814;
t146 = t89.*3.090232306167814;
t153 = t112.*3.090232306167814;
t210 = t126+t135+4.217390225409716e-1;
t212 = t127+t136+t171+t183+4.34638039336526e-1;
t214 = t128+t137+t172+t184+t196+t200+4.3170658521965e-1;
t216 = t129+t138+t173+t185+t197+t201+t208+t209+4.192729467215949e-1;
t139 = t2.*t22.*t84.*3.090232306167814;
t140 = t3.*t23.*t84.*3.090232306167814;
t142 = t4.*t24.*t87.*3.090232306167814;
t143 = t5.*t25.*t87.*3.090232306167814;
t144 = t6.*t26.*t87.*3.090232306167814;
t145 = t7.*t27.*t87.*3.090232306167814;
t147 = t8.*t28.*t90.*3.090232306167814;
t148 = t9.*t29.*t90.*3.090232306167814;
t149 = t10.*t30.*t90.*3.090232306167814;
t150 = t11.*t31.*t90.*3.090232306167814;
t151 = t12.*t32.*t90.*3.090232306167814;
t152 = t13.*t33.*t90.*3.090232306167814;
t154 = t14.*t34.*t113.*3.090232306167814;
t155 = t15.*t35.*t113.*3.090232306167814;
t156 = t16.*t36.*t113.*3.090232306167814;
t157 = t17.*t37.*t113.*3.090232306167814;
t158 = t18.*t38.*t113.*3.090232306167814;
t159 = t19.*t39.*t113.*3.090232306167814;
t160 = t20.*t40.*t113.*3.090232306167814;
t161 = t21.*t41.*t113.*3.090232306167814;
t211 = 1.0./sqrt(t210);
t213 = 1.0./sqrt(t212);
t215 = 1.0./sqrt(t214);
t217 = 1.0./sqrt(t216);
c = [h1.*(-7.0./1.0e+2)-h_pre1.*6.01844e-2-x01.*7.3835857e-1-x02.*9.29861e-2-x03.*1.1378519e-1+4.390411263957968e+6.*7.071067811865475e+6.*2.563103131089201e-14+2.1e+1;h1.*(-6.018440000000001e-2)-h2.*(7.0./1.0e+2)-h_pre1.*5.269815726e-2-x01.*6.516934369479999e-1-x02.*1.20602808595e-1-x03.*1.38518786228e-1+1.281551565544601./t211+2.1e+1;h1.*(-5.269815726e-2)-h2.*6.018440000000001e-2-h3.*(7.0./1.0e+2)-h_pre1.*4.6896232582842e-2-x01.*5.839497352957255e-1-x02.*1.398404002765989e-1-x03.*1.511950581340309e-1+1.281551565544601./t213+2.1e+1;h1.*(-4.6896232582842e-2)-h2.*5.269815726e-2-h3.*6.018440000000001e-2-h4.*(7.0./1.0e+2)-h_pre1.*4.23203041048965e-2-x01.*5.300341747154118e-1-x02.*1.528276905043708e-1-x03.*1.560705618258018e-1+1.281551565544601./t215+2.1e+1;h1.*(-4.23203041048965e-2)-h2.*4.6896232582842e-2-h3.*5.269815726e-2-h4.*6.018440000000001e-2-h5.*(7.0./1.0e+2)-h_pre1.*3.864364062040826e-2-x01.*4.863080850470739e-1-x02.*1.611409854004705e-1-x03.*1.560067791229908e-1+1.281551565544601./t217+2.1e+1;-h1;-h2+t134;-h3+t141;-h4+t146;-h5+t153;h1-4.5e+1;h2+t134-4.5e+1;h3+t141-4.5e+1;h4+t146-4.5e+1;h5+t153-4.5e+1];
if nargout > 1
    ceq = zeros(0,0);
end
if nargout > 2
    gradc = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-7.0./1.0e+2,0.0,0.0,0.0,0.0,t118.*t211.*sign(t114).*8.970860958812204e-2,t130.*t211.*sign(t122).*8.970860958812204e-2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,t165.*t168.*t213.*7.712941204136247e-2,t177.*t180.*t213.*7.712941204136247e-2,t165.*t168.*t213.*8.970860958812204e-2,t177.*t180.*t213.*8.970860958812204e-2,t119.*t213.*sign(t115).*8.970860958812204e-2,t131.*t213.*sign(t123).*8.970860958812204e-2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,t188.*t190.*t215.*6.753540593786856e-2,t194.*t198.*t215.*6.753540593786856e-2,t188.*t190.*t215.*7.712941204136247e-2,t194.*t198.*t215.*7.712941204136247e-2,t166.*t169.*t215.*7.712941204136247e-2,t178.*t181.*t215.*7.712941204136247e-2,t188.*t190.*t215.*8.970860958812204e-2,t194.*t198.*t215.*8.970860958812204e-2,t166.*t169.*t215.*8.970860958812204e-2,t178.*t181.*t215.*8.970860958812204e-2,t120.*t215.*sign(t116).*8.970860958812204e-2,t132.*t215.*sign(t124).*8.970860958812204e-2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,t206.*t207.*t217.*6.009994028468487e-2,t204.*t205.*t217.*6.009994028468487e-2,t206.*t207.*t217.*6.753540593786856e-2,t204.*t205.*t217.*6.753540593786856e-2,t189.*t191.*t217.*6.753540593786856e-2,t195.*t199.*t217.*6.753540593786856e-2,t206.*t207.*t217.*7.712941204136247e-2,t204.*t205.*t217.*7.712941204136247e-2,t189.*t191.*t217.*7.712941204136247e-2,t195.*t199.*t217.*7.712941204136247e-2,t167.*t170.*t217.*7.712941204136247e-2,t179.*t182.*t217.*7.712941204136247e-2,t206.*t207.*t217.*8.970860958812204e-2,t204.*t205.*t217.*8.970860958812204e-2,t189.*t191.*t217.*8.970860958812204e-2,t195.*t199.*t217.*8.970860958812204e-2,t167.*t170.*t217.*8.970860958812204e-2,t179.*t182.*t217.*8.970860958812204e-2,t121.*t217.*sign(t117).*8.970860958812204e-2,t133.*t217.*sign(t125).*8.970860958812204e-2,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,t139,t140,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,t142,t143,t144,t145,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t147,t148,t149,t150,t151,t152,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t154,t155,t156,t157,t158,t159,t160,t161,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,t139,t140,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,t142,t143,t144,t145,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t147,t148,t149,t150,t151,t152,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,t154,t155,t156,t157,t158,t159,t160,t161,0.0,0.0,0.0,0.0,1.0],[25,15]);
end
if nargout > 3
    gradceq = zeros(0,0);
end