function [c,ceq,gradc,gradceq] = constraint_AdfPartTime_Nh10(in1)
%CONSTRAINT_ADFPARTTIME_NH10
%    [C,CEQ,GRADC,GRADCEQ] = CONSTRAINT_ADFPARTTIME_NH10(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.4.
%    19-Oct-2021 03:13:48

M_given_vec1 = in1(15,:);
M_given_vec2 = in1(16,:);
M_given_vec3 = in1(17,:);
M_given_vec4 = in1(18,:);
M_given_vec5 = in1(19,:);
M_given_vec6 = in1(20,:);
M_given_vec7 = in1(21,:);
M_given_vec8 = in1(22,:);
M_given_vec9 = in1(23,:);
M_given_vec10 = in1(24,:);
M_given_vec11 = in1(25,:);
M_given_vec12 = in1(26,:);
M_given_vec13 = in1(27,:);
M_given_vec14 = in1(28,:);
M_given_vec15 = in1(29,:);
M_given_vec16 = in1(30,:);
M_given_vec17 = in1(31,:);
M_given_vec18 = in1(32,:);
M_given_vec19 = in1(33,:);
M_given_vec20 = in1(34,:);
M_given_vec21 = in1(35,:);
M_given_vec22 = in1(36,:);
M_given_vec23 = in1(37,:);
M_given_vec24 = in1(38,:);
M_given_vec25 = in1(39,:);
M_given_vec26 = in1(40,:);
M_given_vec27 = in1(41,:);
M_given_vec28 = in1(42,:);
M_given_vec29 = in1(43,:);
M_given_vec30 = in1(44,:);
M_given_vec31 = in1(45,:);
M_given_vec32 = in1(46,:);
M_given_vec33 = in1(47,:);
M_given_vec34 = in1(48,:);
M_given_vec35 = in1(49,:);
M_given_vec36 = in1(50,:);
M_given_vec37 = in1(51,:);
M_given_vec38 = in1(52,:);
M_given_vec39 = in1(53,:);
M_given_vec40 = in1(54,:);
M_given_vec41 = in1(55,:);
M_given_vec42 = in1(56,:);
M_given_vec43 = in1(57,:);
M_given_vec44 = in1(58,:);
M_given_vec45 = in1(59,:);
M_given_vec46 = in1(60,:);
M_given_vec47 = in1(61,:);
M_given_vec48 = in1(62,:);
M_given_vec49 = in1(63,:);
M_given_vec50 = in1(64,:);
M_given_vec51 = in1(65,:);
M_given_vec52 = in1(66,:);
M_given_vec53 = in1(67,:);
M_given_vec54 = in1(68,:);
M_given_vec55 = in1(69,:);
M_given_vec56 = in1(70,:);
M_given_vec57 = in1(71,:);
M_given_vec58 = in1(72,:);
M_given_vec59 = in1(73,:);
M_given_vec60 = in1(74,:);
M_given_vec61 = in1(75,:);
M_given_vec62 = in1(76,:);
M_given_vec63 = in1(77,:);
M_given_vec64 = in1(78,:);
M_given_vec65 = in1(79,:);
M_given_vec66 = in1(80,:);
M_given_vec67 = in1(81,:);
M_given_vec68 = in1(82,:);
M_given_vec69 = in1(83,:);
M_given_vec70 = in1(84,:);
M_given_vec71 = in1(85,:);
M_given_vec72 = in1(86,:);
M_given_vec73 = in1(87,:);
M_given_vec74 = in1(88,:);
M_given_vec75 = in1(89,:);
M_given_vec76 = in1(90,:);
M_given_vec77 = in1(91,:);
M_given_vec78 = in1(92,:);
M_given_vec79 = in1(93,:);
M_given_vec80 = in1(94,:);
M_given_vec81 = in1(95,:);
M_given_vec82 = in1(96,:);
M_given_vec83 = in1(97,:);
M_given_vec84 = in1(98,:);
M_given_vec85 = in1(99,:);
M_given_vec86 = in1(100,:);
M_given_vec87 = in1(101,:);
M_given_vec88 = in1(102,:);
M_given_vec89 = in1(103,:);
M_given_vec90 = in1(104,:);
h1 = in1(1,:);
h2 = in1(2,:);
h3 = in1(3,:);
h4 = in1(4,:);
h5 = in1(5,:);
h6 = in1(6,:);
h7 = in1(7,:);
h8 = in1(8,:);
h9 = in1(9,:);
h10 = in1(10,:);
u0 = in1(14,:);
x01 = in1(11,:);
x02 = in1(12,:);
x03 = in1(13,:);
t2 = abs(M_given_vec1);
t3 = abs(M_given_vec2);
t4 = abs(M_given_vec3);
t5 = abs(M_given_vec4);
t6 = abs(M_given_vec5);
t7 = abs(M_given_vec6);
t8 = abs(M_given_vec7);
t9 = abs(M_given_vec8);
t10 = abs(M_given_vec9);
t11 = abs(M_given_vec10);
t12 = abs(M_given_vec11);
t13 = abs(M_given_vec12);
t14 = abs(M_given_vec13);
t15 = abs(M_given_vec14);
t16 = abs(M_given_vec15);
t17 = abs(M_given_vec16);
t18 = abs(M_given_vec17);
t19 = abs(M_given_vec18);
t20 = abs(M_given_vec19);
t21 = abs(M_given_vec20);
t22 = abs(M_given_vec21);
t23 = abs(M_given_vec22);
t24 = abs(M_given_vec23);
t25 = abs(M_given_vec24);
t26 = abs(M_given_vec25);
t27 = abs(M_given_vec26);
t28 = abs(M_given_vec27);
t29 = abs(M_given_vec28);
t30 = abs(M_given_vec29);
t31 = abs(M_given_vec30);
t32 = abs(M_given_vec31);
t33 = abs(M_given_vec32);
t34 = abs(M_given_vec33);
t35 = abs(M_given_vec34);
t36 = abs(M_given_vec35);
t37 = abs(M_given_vec36);
t38 = abs(M_given_vec37);
t39 = abs(M_given_vec38);
t40 = abs(M_given_vec39);
t41 = abs(M_given_vec40);
t42 = abs(M_given_vec41);
t43 = abs(M_given_vec42);
t44 = abs(M_given_vec43);
t45 = abs(M_given_vec44);
t46 = abs(M_given_vec45);
t47 = abs(M_given_vec46);
t48 = abs(M_given_vec47);
t49 = abs(M_given_vec48);
t50 = abs(M_given_vec49);
t51 = abs(M_given_vec50);
t52 = abs(M_given_vec51);
t53 = abs(M_given_vec52);
t54 = abs(M_given_vec53);
t55 = abs(M_given_vec54);
t56 = abs(M_given_vec55);
t57 = abs(M_given_vec56);
t58 = abs(M_given_vec57);
t59 = abs(M_given_vec58);
t60 = abs(M_given_vec59);
t61 = abs(M_given_vec60);
t62 = abs(M_given_vec61);
t63 = abs(M_given_vec62);
t64 = abs(M_given_vec63);
t65 = abs(M_given_vec64);
t66 = abs(M_given_vec65);
t67 = abs(M_given_vec66);
t68 = abs(M_given_vec67);
t69 = abs(M_given_vec68);
t70 = abs(M_given_vec69);
t71 = abs(M_given_vec70);
t72 = abs(M_given_vec71);
t73 = abs(M_given_vec72);
t74 = abs(M_given_vec73);
t75 = abs(M_given_vec74);
t76 = abs(M_given_vec75);
t77 = abs(M_given_vec76);
t78 = abs(M_given_vec77);
t79 = abs(M_given_vec78);
t80 = abs(M_given_vec79);
t81 = abs(M_given_vec80);
t82 = abs(M_given_vec81);
t83 = abs(M_given_vec82);
t84 = abs(M_given_vec83);
t85 = abs(M_given_vec84);
t86 = abs(M_given_vec85);
t87 = abs(M_given_vec86);
t88 = abs(M_given_vec87);
t89 = abs(M_given_vec88);
t90 = abs(M_given_vec89);
t91 = abs(M_given_vec90);
t92 = t2.^2;
t93 = t3.^2;
t94 = t4.^2;
t95 = t5.^2;
t96 = t6.^2;
t97 = t7.^2;
t98 = t8.^2;
t99 = t9.^2;
t100 = t10.^2;
t101 = t11.^2;
t102 = t12.^2;
t103 = t13.^2;
t104 = t14.^2;
t105 = t15.^2;
t106 = t16.^2;
t107 = t17.^2;
t108 = t18.^2;
t109 = t19.^2;
t110 = t20.^2;
t111 = t21.^2;
t112 = t22.^2;
t113 = t23.^2;
t114 = t24.^2;
t115 = t25.^2;
t116 = t26.^2;
t117 = t27.^2;
t118 = t28.^2;
t119 = t29.^2;
t120 = t30.^2;
t121 = t31.^2;
t122 = t32.^2;
t123 = t33.^2;
t124 = t34.^2;
t125 = t35.^2;
t126 = t36.^2;
t127 = t37.^2;
t128 = t38.^2;
t129 = t39.^2;
t130 = t40.^2;
t131 = t41.^2;
t132 = t42.^2;
t133 = t43.^2;
t134 = t44.^2;
t135 = t45.^2;
t136 = t46.^2;
t137 = t47.^2;
t138 = t48.^2;
t139 = t49.^2;
t140 = t50.^2;
t141 = t51.^2;
t142 = t52.^2;
t143 = t53.^2;
t144 = t54.^2;
t145 = t55.^2;
t146 = t56.^2;
t147 = t57.^2;
t148 = t58.^2;
t149 = t59.^2;
t150 = t60.^2;
t151 = t61.^2;
t152 = t62.^2;
t153 = t63.^2;
t154 = t64.^2;
t155 = t65.^2;
t156 = t66.^2;
t157 = t67.^2;
t158 = t68.^2;
t159 = t69.^2;
t160 = t70.^2;
t161 = t71.^2;
t162 = t72.^2;
t163 = t73.^2;
t164 = t74.^2;
t165 = t75.^2;
t166 = t76.^2;
t167 = t77.^2;
t168 = t78.^2;
t169 = t79.^2;
t170 = t80.^2;
t171 = t81.^2;
t172 = t82.^2;
t173 = t83.^2;
t174 = t84.^2;
t175 = t85.^2;
t176 = t86.^2;
t177 = t87.^2;
t178 = t88.^2;
t179 = t89.^2;
t180 = t90.^2;
t181 = t91.^2;
t182 = t92+t93;
t184 = t94+t95+t96+t97;
t186 = t98+t99+t100+t101+t102+t103;
t188 = t104+t105+t106+t107+t108+t109+t110+t111;
t190 = t112+t113+t114+t115+t116+t117+t118+t119+t120+t121;
t193 = t122+t123+t124+t125+t126+t127+t128+t129+t130+t131+t132+t133;
t196 = t134+t135+t136+t137+t138+t139+t140+t141+t142+t143+t144+t145+t146+t147;
t199 = t148+t149+t150+t151+t152+t153+t154+t155+t156+t157+t158+t159+t160+t161+t162+t163;
t202 = t164+t165+t166+t167+t168+t169+t170+t171+t172+t173+t174+t175+t176+t177+t178+t179+t180+t181;
t183 = sqrt(t182);
t185 = sqrt(t184);
t187 = sqrt(t186);
t189 = sqrt(t188);
t191 = sqrt(t190);
t194 = sqrt(t193);
t197 = sqrt(t196);
t200 = sqrt(t199);
t203 = sqrt(t202);
t192 = t183.*3.090232306167814;
t195 = t185.*3.090232306167814;
t198 = t187.*3.090232306167814;
t201 = t189.*3.090232306167814;
t204 = t191.*3.090232306167814;
t205 = t194.*3.090232306167814;
t206 = t197.*3.090232306167814;
t207 = t200.*3.090232306167814;
t208 = t203.*3.090232306167814;
c = [h1.*(-7.0./1.0e+2)-u0.*6.01844e-2-x01.*7.3835857e-1-x02.*9.29861e-2-x03.*1.1378519e-1+4.390411263957968e+6.*7.071067811865475e+6.*2.563103131089201e-14+2.1e+1;h1.*(-6.018440000000001e-2)-h2.*(7.0./1.0e+2)-u0.*5.269815726e-2-x01.*6.516934369479999e-1-x02.*1.20602808595e-1-x03.*1.38518786228e-1+sqrt(abs(M_given_vec1.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec2.*(7.0./1.0e+2)+1.23107e-2).^2+4.217390225409716e-1).*1.281551565544601+2.1e+1;h1.*(-5.269815726e-2)-h2.*6.018440000000001e-2-h3.*(7.0./1.0e+2)-u0.*4.6896232582842e-2-x01.*5.839497352957255e-1-x02.*1.398404002765989e-1-x03.*1.511950581340309e-1+sqrt(abs(M_given_vec1.*6.018440000000001e-2+M_given_vec3.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec2.*6.018440000000001e-2+M_given_vec4.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec5.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec6.*(7.0./1.0e+2)+1.23107e-2).^2+4.34638039336526e-1).*1.281551565544601+2.1e+1;h1.*(-4.6896232582842e-2)-h2.*5.269815726e-2-h3.*6.018440000000001e-2-h4.*(7.0./1.0e+2)-u0.*4.23203041048965e-2-x01.*5.300341747154118e-1-x02.*1.528276905043708e-1-x03.*1.560705618258018e-1+sqrt(abs(M_given_vec2.*5.269815726e-2+M_given_vec4.*6.018440000000001e-2+M_given_vec8.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec5.*6.018440000000001e-2+M_given_vec9.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec6.*6.018440000000001e-2+M_given_vec10.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec11.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec1.*5.269815726e-2+M_given_vec3.*6.018440000000001e-2+M_given_vec7.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec12.*(7.0./1.0e+2)+1.23107e-2).^2+4.3170658521965e-1).*1.281551565544601+2.1e+1;h1.*(-4.23203041048965e-2)-h2.*4.6896232582842e-2-h3.*5.269815726e-2-h4.*6.018440000000001e-2-h5.*(7.0./1.0e+2)-u0.*3.864364062040826e-2-x01.*4.863080850470739e-1-x02.*1.611409854004705e-1-x03.*1.560067791229908e-1+sqrt(abs(M_given_vec2.*4.6896232582842e-2+M_given_vec4.*5.269815726e-2+M_given_vec8.*6.018440000000001e-2+M_given_vec14.*(7.0./1.0e+2)+9.16553375393378e-3).^2+abs(M_given_vec6.*5.269815726e-2+M_given_vec10.*6.018440000000001e-2+M_given_vec16.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec1.*4.6896232582842e-2+M_given_vec3.*5.269815726e-2+M_given_vec7.*6.018440000000001e-2+M_given_vec13.*(7.0./1.0e+2)+5.209861593273429e-1).^2+abs(M_given_vec11.*6.018440000000001e-2+M_given_vec17.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec12.*6.018440000000001e-2+M_given_vec18.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec19.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec5.*5.269815726e-2+M_given_vec9.*6.018440000000001e-2+M_given_vec15.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec20.*(7.0./1.0e+2)+1.23107e-2).^2+4.192729467215949e-1).*1.281551565544601+2.1e+1;h1.*(-3.864364062040826e-2)-h2.*4.23203041048965e-2-h3.*4.6896232582842e-2-h4.*5.269815726e-2-h5.*6.018440000000001e-2-h6.*(7.0./1.0e+2)-u0.*3.563243898218996e-2-x01.*4.501614110511092e-1-x02.*1.659537299875466e-1-x03.*1.52912969169178e-1+sqrt(abs(M_given_vec6.*4.6896232582842e-2+M_given_vec10.*5.269815726e-2+M_given_vec16.*6.018440000000001e-2+M_given_vec24.*(7.0./1.0e+2)+9.16553375393378e-3).^2+abs(M_given_vec12.*5.269815726e-2+M_given_vec18.*6.018440000000001e-2+M_given_vec26.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec5.*4.6896232582842e-2+M_given_vec9.*5.269815726e-2+M_given_vec15.*6.018440000000001e-2+M_given_vec23.*(7.0./1.0e+2)+5.209861593273429e-1).^2+abs(M_given_vec19.*6.018440000000001e-2+M_given_vec27.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec20.*6.018440000000001e-2+M_given_vec28.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec29.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec2.*4.23203041048965e-2+M_given_vec4.*4.6896232582842e-2+M_given_vec8.*5.269815726e-2+M_given_vec14.*6.018440000000001e-2+M_given_vec22.*(7.0./1.0e+2)+8.493515150867791e-3).^2+abs(M_given_vec11.*5.269815726e-2+M_given_vec17.*6.018440000000001e-2+M_given_vec25.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec1.*4.23203041048965e-2+M_given_vec3.*4.6896232582842e-2+M_given_vec7.*5.269815726e-2+M_given_vec13.*6.018440000000001e-2+M_given_vec21.*(7.0./1.0e+2)+5.089251486436654e-1).^2+abs(M_given_vec30.*(7.0./1.0e+2)+1.23107e-2).^2+4.018782339796733e-1).*1.281551565544601+2.1e+1;h1.*(-3.563243898218996e-2)-h2.*3.864364062040826e-2-h3.*4.23203041048965e-2-h4.*4.6896232582842e-2-h5.*5.269815726e-2-h6.*6.018440000000001e-2-h7.*(7.0./1.0e+2)-u0.*3.250702115350292e-2-x01.*4.045901942329888e-1-x02.*1.676547781821115e-1-x03.*3.273915727624493e-2-pi.*(u0./2.5e+2+x01.*9.89e-2+x02.*(2.0./6.25e+2)+x03.*7.541e-1).*4.867370981226723e-2+sqrt(abs(M_given_vec12.*4.6896232582842e-2+M_given_vec18.*5.269815726e-2+M_given_vec26.*6.018440000000001e-2+M_given_vec36.*(7.0./1.0e+2)+9.16553375393378e-3).^2+(pi.*4.867370981226723e-5+7.297982134640808e-3).^2+abs(M_given_vec20.*5.269815726e-2+M_given_vec28.*6.018440000000001e-2+M_given_vec38.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec11.*4.6896232582842e-2+M_given_vec17.*5.269815726e-2+M_given_vec25.*6.018440000000001e-2+M_given_vec35.*(7.0./1.0e+2)+5.209861593273429e-1).^2+abs(M_given_vec29.*6.018440000000001e-2+M_given_vec39.*(7.0./1.0e+2)+5.112942700500001e-1).^2+(pi.*9.126320589800106e-2+1.84711268860095e-1).^2+abs(M_given_vec30.*6.018440000000001e-2+M_given_vec40.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec41.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec6.*4.23203041048965e-2+M_given_vec10.*4.6896232582842e-2+M_given_vec16.*5.269815726e-2+M_given_vec24.*6.018440000000001e-2+M_given_vec34.*(7.0./1.0e+2)+8.493515150867791e-3).^2+abs(M_given_vec2.*3.864364062040826e-2+M_given_vec4.*4.23203041048965e-2+M_given_vec8.*4.6896232582842e-2+M_given_vec14.*5.269815726e-2+M_given_vec22.*6.018440000000001e-2+M_given_vec32.*(7.0./1.0e+2)+7.931165882184848e-3).^2+abs(M_given_vec1.*3.864364062040826e-2+M_given_vec3.*4.23203041048965e-2+M_given_vec7.*4.6896232582842e-2+M_given_vec13.*5.269815726e-2+M_given_vec21.*6.018440000000001e-2+M_given_vec31.*(7.0./1.0e+2)+4.915478924656504e-1).^2+abs(M_given_vec19.*5.269815726e-2+M_given_vec27.*6.018440000000001e-2+M_given_vec37.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec5.*4.23203041048965e-2+M_given_vec9.*4.6896232582842e-2+M_given_vec15.*5.269815726e-2+M_given_vec23.*6.018440000000001e-2+M_given_vec33.*(7.0./1.0e+2)+5.089251486436654e-1).^2+abs(M_given_vec42.*(7.0./1.0e+2)+1.23107e-2).^2+1.60196e-1).*1.281551565544601+2.1e+1;h1.*(-3.311867303017964e-2)-h2.*3.563243898218996e-2-h3.*3.864364062040826e-2-h4.*4.23203041048965e-2-h5.*4.6896232582842e-2-h6.*5.269815726e-2-h7.*6.018440000000001e-2-h8.*(7.0./1.0e+2)-u0.*3.098099798927503e-2-x01.*3.936012373785028e-1-x02.*1.683726815445217e-1-x03.*1.422436508180262e-1+sqrt(abs(M_given_vec20.*4.6896232582842e-2+M_given_vec28.*5.269815726e-2+M_given_vec38.*6.018440000000001e-2+M_given_vec50.*(7.0./1.0e+2)+9.16553375393378e-3).^2+abs(M_given_vec30.*5.269815726e-2+M_given_vec40.*6.018440000000001e-2+M_given_vec52.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec19.*4.6896232582842e-2+M_given_vec27.*5.269815726e-2+M_given_vec37.*6.018440000000001e-2+M_given_vec49.*(7.0./1.0e+2)+5.209861593273429e-1).^2+abs(M_given_vec41.*6.018440000000001e-2+M_given_vec53.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec42.*6.018440000000001e-2+M_given_vec54.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec1.*3.563243898218996e-2+M_given_vec3.*3.864364062040826e-2+M_given_vec7.*4.23203041048965e-2+M_given_vec13.*4.6896232582842e-2+M_given_vec21.*5.269815726e-2+M_given_vec31.*6.018440000000001e-2+M_given_vec43.*(7.0./1.0e+2)+4.714230860523039e-1).^2+abs(M_given_vec55.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec12.*4.23203041048965e-2+M_given_vec18.*4.6896232582842e-2+M_given_vec26.*5.269815726e-2+M_given_vec36.*6.018440000000001e-2+M_given_vec48.*(7.0./1.0e+2)+8.493515150867791e-3).^2+abs(M_given_vec6.*3.864364062040826e-2+M_given_vec10.*4.23203041048965e-2+M_given_vec16.*4.6896232582842e-2+M_given_vec24.*5.269815726e-2+M_given_vec34.*6.018440000000001e-2+M_given_vec46.*(7.0./1.0e+2)+7.931165882184848e-3).^2+abs(M_given_vec5.*3.864364062040826e-2+M_given_vec9.*4.23203041048965e-2+M_given_vec15.*4.6896232582842e-2+M_given_vec23.*5.269815726e-2+M_given_vec33.*6.018440000000001e-2+M_given_vec45.*(7.0./1.0e+2)+4.915478924656504e-1).^2+abs(M_given_vec2.*3.563243898218996e-2+M_given_vec4.*3.864364062040826e-2+M_given_vec8.*4.23203041048965e-2+M_given_vec14.*4.6896232582842e-2+M_given_vec22.*5.269815726e-2+M_given_vec32.*6.018440000000001e-2+M_given_vec44.*(7.0./1.0e+2)+7.450895103809986e-3).^2+abs(M_given_vec29.*5.269815726e-2+M_given_vec39.*6.018440000000001e-2+M_given_vec51.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec11.*4.23203041048965e-2+M_given_vec17.*4.6896232582842e-2+M_given_vec25.*5.269815726e-2+M_given_vec35.*6.018440000000001e-2+M_given_vec47.*(7.0./1.0e+2)+5.089251486436654e-1).^2+abs(M_given_vec56.*(7.0./1.0e+2)+1.23107e-2).^2+3.629152829958496e-1).*1.281551565544601+2.1e+1;h1.*(-3.098099798927505e-2)-h2.*3.311867303017964e-2-h3.*3.563243898218996e-2-h4.*3.864364062040826e-2-h5.*4.23203041048965e-2-h6.*4.6896232582842e-2-h7.*5.269815726e-2-h8.*6.018440000000001e-2-h9.*(7.0./1.0e+2)-u0.*2.913129730903443e-2-x01.*3.708324979224532e-1-x02.*1.671388171384892e-1-x03.*1.360195943130286e-1+sqrt(abs(M_given_vec30.*4.6896232582842e-2+M_given_vec40.*5.269815726e-2+M_given_vec52.*6.018440000000001e-2+M_given_vec66.*(7.0./1.0e+2)+9.16553375393378e-3).^2+abs(M_given_vec42.*5.269815726e-2+M_given_vec54.*6.018440000000001e-2+M_given_vec68.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec29.*4.6896232582842e-2+M_given_vec39.*5.269815726e-2+M_given_vec51.*6.018440000000001e-2+M_given_vec65.*(7.0./1.0e+2)+5.209861593273429e-1).^2+abs(M_given_vec55.*6.018440000000001e-2+M_given_vec69.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec56.*6.018440000000001e-2+M_given_vec70.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec5.*3.563243898218996e-2+M_given_vec9.*3.864364062040826e-2+M_given_vec15.*4.23203041048965e-2+M_given_vec23.*4.6896232582842e-2+M_given_vec33.*5.269815726e-2+M_given_vec45.*6.018440000000001e-2+M_given_vec59.*(7.0./1.0e+2)+4.714230860523039e-1).^2+abs(M_given_vec71.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec1.*3.311867303017964e-2+M_given_vec3.*3.563243898218996e-2+M_given_vec7.*3.864364062040826e-2+M_given_vec13.*4.23203041048965e-2+M_given_vec21.*4.6896232582842e-2+M_given_vec31.*5.269815726e-2+M_given_vec43.*6.018440000000001e-2+M_given_vec57.*(7.0./1.0e+2)+4.501886507822688e-1).^2+abs(M_given_vec2.*3.311867303017964e-2+M_given_vec4.*3.563243898218996e-2+M_given_vec8.*3.864364062040826e-2+M_given_vec14.*4.23203041048965e-2+M_given_vec22.*4.6896232582842e-2+M_given_vec32.*5.269815726e-2+M_given_vec44.*6.018440000000001e-2+M_given_vec58.*(7.0./1.0e+2)+7.032901441800926e-3).^2+abs(M_given_vec20.*4.23203041048965e-2+M_given_vec28.*4.6896232582842e-2+M_given_vec38.*5.269815726e-2+M_given_vec50.*6.018440000000001e-2+M_given_vec64.*(7.0./1.0e+2)+8.493515150867791e-3).^2+abs(M_given_vec12.*3.864364062040826e-2+M_given_vec18.*4.23203041048965e-2+M_given_vec26.*4.6896232582842e-2+M_given_vec36.*5.269815726e-2+M_given_vec48.*6.018440000000001e-2+M_given_vec62.*(7.0./1.0e+2)+7.931165882184848e-3).^2+abs(M_given_vec11.*3.864364062040826e-2+M_given_vec17.*4.23203041048965e-2+M_given_vec25.*4.6896232582842e-2+M_given_vec35.*5.269815726e-2+M_given_vec47.*6.018440000000001e-2+M_given_vec61.*(7.0./1.0e+2)+4.915478924656504e-1).^2+abs(M_given_vec6.*3.563243898218996e-2+M_given_vec10.*3.864364062040826e-2+M_given_vec16.*4.23203041048965e-2+M_given_vec24.*4.6896232582842e-2+M_given_vec34.*5.269815726e-2+M_given_vec46.*6.018440000000001e-2+M_given_vec60.*(7.0./1.0e+2)+7.450895103809986e-3).^2+abs(M_given_vec41.*5.269815726e-2+M_given_vec53.*6.018440000000001e-2+M_given_vec67.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec19.*4.23203041048965e-2+M_given_vec27.*4.6896232582842e-2+M_given_vec37.*5.269815726e-2+M_given_vec49.*6.018440000000001e-2+M_given_vec63.*(7.0./1.0e+2)+5.089251486436654e-1).^2+abs(M_given_vec72.*(7.0./1.0e+2)+1.23107e-2).^2+3.441628165265673e-1).*1.281551565544601+2.1e+1;h1.*(-2.913129730903444e-2)-h2.*3.098099798927505e-2-h3.*3.311867303017964e-2-h4.*3.563243898218996e-2-h5.*3.864364062040826e-2-h6.*4.23203041048965e-2-h7.*4.6896232582842e-2-h8.*5.269815726e-2-h9.*6.018440000000001e-2-h10.*(7.0./1.0e+2)-u0.*2.750518613465478e-2-x01.*3.506789259153652e-1-x02.*1.648216694384918e-1-x03.*1.29709497168834e-1+sqrt(abs(M_given_vec42.*4.6896232582842e-2+M_given_vec54.*5.269815726e-2+M_given_vec68.*6.018440000000001e-2+M_given_vec84.*(7.0./1.0e+2)+9.16553375393378e-3).^2+abs(M_given_vec56.*5.269815726e-2+M_given_vec70.*6.018440000000001e-2+M_given_vec86.*(7.0./1.0e+2)+9.985843755069999e-3).^2+abs(M_given_vec41.*4.6896232582842e-2+M_given_vec53.*5.269815726e-2+M_given_vec67.*6.018440000000001e-2+M_given_vec83.*(7.0./1.0e+2)+5.209861593273429e-1).^2+abs(M_given_vec71.*6.018440000000001e-2+M_given_vec87.*(7.0./1.0e+2)+5.112942700500001e-1).^2+abs(M_given_vec1.*3.098099798927505e-2+M_given_vec3.*3.311867303017964e-2+M_given_vec7.*3.563243898218996e-2+M_given_vec13.*3.864364062040826e-2+M_given_vec21.*4.23203041048965e-2+M_given_vec31.*4.6896232582842e-2+M_given_vec43.*5.269815726e-2+M_given_vec57.*6.018440000000001e-2+M_given_vec73.*(7.0./1.0e+2)+4.28861775318447e-1).^2+abs(M_given_vec72.*6.018440000000001e-2+M_given_vec88.*(7.0./1.0e+2)+1.100872177e-2).^2+abs(M_given_vec11.*3.563243898218996e-2+M_given_vec17.*3.864364062040826e-2+M_given_vec25.*4.23203041048965e-2+M_given_vec35.*4.6896232582842e-2+M_given_vec47.*5.269815726e-2+M_given_vec61.*6.018440000000001e-2+M_given_vec77.*(7.0./1.0e+2)+4.714230860523039e-1).^2+abs(M_given_vec89.*(7.0./1.0e+2)+4.745173e-1).^2+abs(M_given_vec5.*3.311867303017964e-2+M_given_vec9.*3.563243898218996e-2+M_given_vec15.*3.864364062040826e-2+M_given_vec23.*4.23203041048965e-2+M_given_vec33.*4.6896232582842e-2+M_given_vec45.*5.269815726e-2+M_given_vec59.*6.018440000000001e-2+M_given_vec75.*(7.0./1.0e+2)+4.501886507822688e-1).^2+abs(M_given_vec6.*3.311867303017964e-2+M_given_vec10.*3.563243898218996e-2+M_given_vec16.*3.864364062040826e-2+M_given_vec24.*4.23203041048965e-2+M_given_vec34.*4.6896232582842e-2+M_given_vec46.*5.269815726e-2+M_given_vec60.*6.018440000000001e-2+M_given_vec76.*(7.0./1.0e+2)+7.032901441800926e-3).^2+abs(M_given_vec30.*4.23203041048965e-2+M_given_vec40.*4.6896232582842e-2+M_given_vec52.*5.269815726e-2+M_given_vec66.*6.018440000000001e-2+M_given_vec82.*(7.0./1.0e+2)+8.493515150867791e-3).^2+abs(M_given_vec2.*3.098099798927505e-2+M_given_vec4.*3.311867303017964e-2+M_given_vec8.*3.563243898218996e-2+M_given_vec14.*3.864364062040826e-2+M_given_vec22.*4.23203041048965e-2+M_given_vec32.*4.6896232582842e-2+M_given_vec44.*5.269815726e-2+M_given_vec58.*6.018440000000001e-2+M_given_vec74.*(7.0./1.0e+2)+6.662897063384196e-3).^2+abs(M_given_vec20.*3.864364062040826e-2+M_given_vec28.*4.23203041048965e-2+M_given_vec38.*4.6896232582842e-2+M_given_vec50.*5.269815726e-2+M_given_vec64.*6.018440000000001e-2+M_given_vec80.*(7.0./1.0e+2)+7.931165882184848e-3).^2+abs(M_given_vec19.*3.864364062040826e-2+M_given_vec27.*4.23203041048965e-2+M_given_vec37.*4.6896232582842e-2+M_given_vec49.*5.269815726e-2+M_given_vec63.*6.018440000000001e-2+M_given_vec79.*(7.0./1.0e+2)+4.915478924656504e-1).^2+abs(M_given_vec12.*3.563243898218996e-2+M_given_vec18.*3.864364062040826e-2+M_given_vec26.*4.23203041048965e-2+M_given_vec36.*4.6896232582842e-2+M_given_vec48.*5.269815726e-2+M_given_vec62.*6.018440000000001e-2+M_given_vec78.*(7.0./1.0e+2)+7.450895103809986e-3).^2+abs(M_given_vec55.*5.269815726e-2+M_given_vec69.*6.018440000000001e-2+M_given_vec85.*(7.0./1.0e+2)+5.237769775973601e-1).^2+abs(M_given_vec29.*4.23203041048965e-2+M_given_vec39.*4.6896232582842e-2+M_given_vec51.*5.269815726e-2+M_given_vec65.*6.018440000000001e-2+M_given_vec81.*(7.0./1.0e+2)+5.089251486436654e-1).^2+abs(M_given_vec90.*(7.0./1.0e+2)+1.23107e-2).^2+3.267405721022847e-1).*1.281551565544601+2.1e+1;-h1;-h2+t192;-h3+t195;-h4+t198;-h5+t201;-h6+t204;-h7+t205;-h8+t206;-h9+t207;-h10+t208;h1-4.5e+1;h2+t192-4.5e+1;h3+t195-4.5e+1;h4+t198-4.5e+1;h5+t201-4.5e+1;h6+t204-4.5e+1;h7+t205-4.5e+1;h8+t206-4.5e+1;h9+t207-4.5e+1;h10+t208-4.5e+1];
if nargout > 1
    ceq = zeros(0,0);
end
if nargout > 2
    gradc = reshape([-7.0./1.0e+2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,0.0,0.0,0.0,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,0.0,0.0,-3.864364062040826e-2,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,0.0,-3.563243898218996e-2,-3.864364062040826e-2,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,0.0,-3.311867303017964e-2,-3.563243898218996e-2,-3.864364062040826e-2,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,0.0,-3.098099798927505e-2,-3.311867303017964e-2,-3.563243898218996e-2,-3.864364062040826e-2,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,0.0,-2.913129730903444e-2,-3.098099798927505e-2,-3.311867303017964e-2,-3.563243898218996e-2,-3.864364062040826e-2,-4.23203041048965e-2,-4.6896232582842e-2,-5.269815726e-2,-6.018440000000001e-2,-7.0./1.0e+2,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0],[10,30]);
end
if nargout > 3
    gradceq = zeros(0,0);
end
