Libname S '/folders/myfolders/sample dataset';

Proc import datafile='/folders/myfolders/sample dataset/Linear Regression Case/
Linear Regression Case Original.xlsx' out=LR dbms=xlsx replace;
getnames=yes;run;

data LR;
set LR;
Total_Spend = cardspent+card2spent;
run;

proc means data= LR n nmiss;
run;

/* Transforming some variables to remove missing values */

data LR;
set LR;
if lntollmon = . then lntollmon = log(tollmon + 1);
if lntollten = . then lntollten = log(tollten + 1);
if lnequipmon = . then lnequipmon = log(equipmon + 1);
if lnequipten = . then lnequipten = log(equipten + 1);
if lncardmon = . then lncardmon = log(cardmon + 1);
if lncardten = . then lncardten = log(cardten + 1);
if lnwiremon = . then lnwiremon = log(wiremon + 1);
if lnwireten = . then lnwireten = log(wireten + 1);
run; 


/* Missing Value Imputation */

data LR;
set LR;
if	townsize	=	.	then	townsize	=	1	;
if	lncreddebt	=	.	then	lncreddebt	=	-0.1304535	;
if	lnothdebt	=	.	then	lnothdebt	=	0.6969153	;
if	commutetime	=	.	then	commutetime	=	25.3455382	;
if	longten	=	    .	then	longten	=	708.8717531		;
if	lnlongten	=	.	then	lnlongten	=	5.6112979	;
if	cardten	=		.	then	cardten	=	720.4783914		;
if	lncardten	=	.	then	lncardten	=	4.6005067	;
run;

ods html file='/folders/myfolders/sample dataset/Linear Regression Case/outliers.xls';
proc means data=LR N Nmiss mean std min P5 P95 max ;
run;
ods html close;

/* Outliers Treatment */

data LR;
set LR;
if	region	>	5	then	region	=	5	;
if	townsize	>	5	then	townsize	=	5	;
if	gender	>	1	then	gender	=	1	;
if	age	>	76	then	age	=	76	;
if	agecat	>	6	then	agecat	=	6	;
if	ed	>	20	then	ed	=	20	;
if	edcat	>	5	then	edcat	=	5	;
if	jobcat	>	6	then	jobcat	=	6	;
if	union	>	1	then	union	=	1	;
if	employ	>	31	then	employ	=	31	;
if	empcat	>	5	then	empcat	=	5	;
if	retire	>	1	then	retire	=	1	;
if	income	>	147	then	income	=	147	;
if	lninc	>	4.9904326	then	lninc	=	4.9904326	;
if	inccat	>	5	then	inccat	=	5	;
if	debtinc	>	22.2	then	debtinc	=	22.2	;
if	creddebt	>	6.385992	then	creddebt	=	6.385992	;
if	lncreddebt	>	1.8541043	then	lncreddebt	=	1.8541043	;
if	othdebt	>	11.830208	then	othdebt	=	11.830208	;
if	lnothdebt	>	2.4706554	then	lnothdebt	=	2.4706554	;
if	default	>	1	then	default	=	1	;
if	jobsat	>	5	then	jobsat	=	5	;
if	marital	>	1	then	marital	=	1	;
if	spoused	>	18	then	spoused	=	18	;
if	spousedcat	>	4	then	spousedcat	=	4	;
if	reside	>	5	then	reside	=	5	;
if	pets	>	10	then	pets	=	10	;
if	pets_cats	>	2	then	pets_cats	=	2	;
if	pets_dogs	>	2	then	pets_dogs	=	2	;
if	pets_birds	>	1	then	pets_birds	=	1	;
if	pets_reptiles	>	0	then	pets_reptiles	=	0	;
if	pets_small	>	1	then	pets_small	=	1	;
if	pets_saltfish	>	0	then	pets_saltfish	=	0	;
if	pets_freshfish	>	8	then	pets_freshfish	=	8	;
if	homeown	>	1	then	homeown	=	1	;
if	hometype	>	4	then	hometype	=	4	;
if	address	>	40	then	address	=	40	;
if	addresscat	>	5	then	addresscat	=	5	;
if	cars	>	4	then	cars	=	4	;
if	carown	>	1	then	carown	=	1	;
if	cartype	>	1	then	cartype	=	1	;
if	carvalue	>	72	then	carvalue	=	72	;
if	carcatvalue	>	3	then	carcatvalue	=	3	;
if	carbought	>	1	then	carbought	=	1	;
if	carbuy	>	1	then	carbuy	=	1	;
if	commute	>	8	then	commute	=	8	;
if	commutecat	>	4	then	commutecat	=	4	;
if	commutetime	>	35	then	commutetime	=	35	;
if	commutecar	>	1	then	commutecar	=	1	;
if	commutemotorcycle	>	1	then	commutemotorcycle	=	1	;
if	commutecarpool	>	1	then	commutecarpool	=	1	;
if	commutebus	>	1	then	commutebus	=	1	;
if	commuterail	>	1	then	commuterail	=	1	;
if	commutepublic	>	1	then	commutepublic	=	1	;
if	commutebike	>	1	then	commutebike	=	1	;
if	commutewalk	>	1	then	commutewalk	=	1	;
if	commutenonmotor	>	1	then	commutenonmotor	=	1	;
if	telecommute	>	1	then	telecommute	=	1	;
if	reason	>	9	then	reason	=	9	;
if	polview	>	6	then	polview	=	6	;
if	polparty	>	1	then	polparty	=	1	;
if	polcontrib	>	1	then	polcontrib	=	1	;
if	vote	>	1	then	vote	=	1	;
if	card	>	4	then	card	=	4	;
if	cardtype	>	4	then	cardtype	=	4	;
if	cardbenefit	>	4	then	cardbenefit	=	4	;
if	cardfee	>	1	then	cardfee	=	1	;
if	cardtenure	>	38	then	cardtenure	=	38	;
if	cardtenurecat	>	5	then	cardtenurecat	=	5	;
if	card2	>	5	then	card2	=	5	;
if	card2type	>	4	then	card2type	=	4	;
if	card2benefit	>	4	then	card2benefit	=	4	;
if	card2fee	>	1	then	card2fee	=	1	;
if	card2tenure	>	29	then	card2tenure	=	29	;
if	card2tenurecat	>	5	then	card2tenurecat	=	5	;
if	carditems	>	16	then	carditems	=	16	;
if	cardspent	>	782.545	then	cardspent	=	782.545	;
if	card2items	>	9	then	card2items	=	9	;
if	card2spent	>	419.51	then	card2spent	=	419.51	;
if	active	>	1	then	active	=	1	;
if	bfast	>	3	then	bfast	=	3	;
if	tenure	>	72	then	tenure	=	72	;
if	churn	>	1	then	churn	=	1	;
if	longmon	>	36.825	then	longmon	=	36.825	;
if	lnlongmon	>	3.6061749	then	lnlongmon	=	3.6061749	;
if	longten	>	2571.1	then	longten	=	2571.1	;
if	lnlongten	>	7.8520866	then	lnlongten	=	7.8520866	;
if	tollfree	>	1	then	tollfree	=	1	;
if	tollmon	>	43.5	then	tollmon	=	43.5	;
if	lntollmon	>	3.7727609	then	lntollmon	=	3.7727609	;
if	tollten	>	2620.33	then	tollten	=	2620.33	;
if	lntollten	>	7.8710536	then	lntollten	=	7.8710536	;
if	equip	>	1	then	equip	=	1	;
if	equipmon	>	49.075	then	equipmon	=	49.075	;
if	lnequipmon	>	3.8933496	then	lnequipmon	=	3.8933496	;
if	equipten	>	2601.35	then	equipten	=	2601.35	;
if	lnequipten	>	7.8637858	then	lnequipten	=	7.8637858	;
if	callcard	>	1	then	callcard	=	1	;
if	cardmon	>	42	then	cardmon	=	42	;
if	lncardmon	>	3.7376696	then	lncardmon	=	3.7376696	;
if	cardten	>	2457.5	then	cardten	=	2457.5	;
if	lncardten	>	7.8068993	then	lncardten	=	7.8068993	;
if	wireless	>	1	then	wireless	=	1	;
if	wiremon	>	51.35	then	wiremon	=	51.35	;
if	lnwiremon	>	3.9386645	then	lnwiremon	=	3.9386645	;
if	wireten	>	2691.28	then	wireten	=	2691.28	;
if	lnwireten	>	7.8977694	then	lnwireten	=	7.8977694	;
if	multline	>	1	then	multline	=	1	;
if	voice	>	1	then	voice	=	1	;
if	pager	>	1	then	pager	=	1	;
if	internet	>	4	then	internet	=	4	;
if	callid	>	1	then	callid	=	1	;
if	callwait	>	1	then	callwait	=	1	;
if	forward	>	1	then	forward	=	1	;
if	confer	>	1	then	confer	=	1	;
if	ebill	>	1	then	ebill	=	1	;
if	owntv	>	1	then	owntv	=	1	;
if	hourstv	>	28	then	hourstv	=	28	;
if	ownvcr	>	1	then	ownvcr	=	1	;
if	owndvd	>	1	then	owndvd	=	1	;
if	owncd	>	1	then	owncd	=	1	;
if	ownpda	>	1	then	ownpda	=	1	;
if	ownpc	>	1	then	ownpc	=	1	;
if	ownipod	>	1	then	ownipod	=	1	;
if	owngame	>	1	then	owngame	=	1	;
if	ownfax	>	1	then	ownfax	=	1	;
if	news	>	1	then	news	=	1	;
if	response_01	>	1	then	response_01	=	1	;
if	response_02	>	1	then	response_02	=	1	;
if	response_03	>	1	then	response_03	=	1	;
if	region	<	1	then	region	=	1	;
if	townsize	<	1	then	townsize	=	1	;
if	gender	<	0	then	gender	=	0	;
if	age	<	20	then	age	=	20	;
if	agecat	<	2	then	agecat	=	2	;
if	ed	<	9	then	ed	=	9	;
if	edcat	<	1	then	edcat	=	1	;
if	jobcat	<	1	then	jobcat	=	1	;
if	union	<	0	then	union	=	0	;
if	employ	<	0	then	employ	=	0	;
if	empcat	<	1	then	empcat	=	1	;
if	retire	<	0	then	retire	=	0	;
if	income	<	13	then	income	=	13	;
if	lninc	<	2.5649494	then	lninc	=	2.5649494	;
if	inccat	<	1	then	inccat	=	1	;
if	debtinc	<	1.9	then	debtinc	=	1.9	;
if	creddebt	<	0.101088	then	creddebt	=	0.101088	;
if	lncreddebt	<	-2.2916748	then	lncreddebt	=	-2.2916748	;
if	othdebt	<	0.287353	then	othdebt	=	0.287353	;
if	lnothdebt	<	-1.2444831	then	lnothdebt	=	-1.2444831	;
if	default	<	0	then	default	=	0	;
if	jobsat	<	1	then	jobsat	=	1	;
if	marital	<	0	then	marital	=	0	;
if	spoused	<	-1	then	spoused	=	-1	;
if	spousedcat	<	-1	then	spousedcat	=	-1	;
if	reside	<	1	then	reside	=	1	;
if	pets	<	0	then	pets	=	0	;
if	pets_cats	<	0	then	pets_cats	=	0	;
if	pets_dogs	<	0	then	pets_dogs	=	0	;
if	pets_birds	<	0	then	pets_birds	=	0	;
if	pets_reptiles	<	0	then	pets_reptiles	=	0	;
if	pets_small	<	0	then	pets_small	=	0	;
if	pets_saltfish	<	0	then	pets_saltfish	=	0	;
if	pets_freshfish	<	0	then	pets_freshfish	=	0	;
if	homeown	<	0	then	homeown	=	0	;
if	hometype	<	1	then	hometype	=	1	;
if	address	<	1	then	address	=	1	;
if	addresscat	<	1	then	addresscat	=	1	;
if	cars	<	0	then	cars	=	0	;
if	carown	<	-1	then	carown	=	-1	;
if	cartype	<	-1	then	cartype	=	-1	;
if	carvalue	<	-1	then	carvalue	=	-1	;
if	carcatvalue	<	-1	then	carcatvalue	=	-1	;
if	carbought	<	-1	then	carbought	=	-1	;
if	carbuy	<	0	then	carbuy	=	0	;
if	commute	<	1	then	commute	=	1	;
if	commutecat	<	1	then	commutecat	=	1	;
if	commutetime	<	16	then	commutetime	=	16	;
if	commutecar	<	0	then	commutecar	=	0	;
if	commutemotorcycle	<	0	then	commutemotorcycle	=	0	;
if	commutecarpool	<	0	then	commutecarpool	=	0	;
if	commutebus	<	0	then	commutebus	=	0	;
if	commuterail	<	0	then	commuterail	=	0	;
if	commutepublic	<	0	then	commutepublic	=	0	;
if	commutebike	<	0	then	commutebike	=	0	;
if	commutewalk	<	0	then	commutewalk	=	0	;
if	commutenonmotor	<	0	then	commutenonmotor	=	0	;
if	telecommute	<	0	then	telecommute	=	0	;
if	reason	<	1	then	reason	=	1	;
if	polview	<	2	then	polview	=	2	;
if	polparty	<	0	then	polparty	=	0	;
if	polcontrib	<	0	then	polcontrib	=	0	;
if	vote	<	0	then	vote	=	0	;
if	card	<	1	then	card	=	1	;
if	cardtype	<	1	then	cardtype	=	1	;
if	cardbenefit	<	1	then	cardbenefit	=	1	;
if	cardfee	<	0	then	cardfee	=	0	;
if	cardtenure	<	1	then	cardtenure	=	1	;
if	cardtenurecat	<	1	then	cardtenurecat	=	1	;
if	card2	<	1	then	card2	=	1	;
if	card2type	<	1	then	card2type	=	1	;
if	card2benefit	<	1	then	card2benefit	=	1	;
if	card2fee	<	0	then	card2fee	=	0	;
if	card2tenure	<	1	then	card2tenure	=	1	;
if	card2tenurecat	<	1	then	card2tenurecat	=	1	;
if	carditems	<	5	then	carditems	=	5	;
if	cardspent	<	91.255	then	cardspent	=	91.255	;
if	card2items	<	1	then	card2items	=	1	;
if	card2spent	<	14.815	then	card2spent	=	14.815	;
if	active	<	0	then	active	=	0	;
if	bfast	<	1	then	bfast	=	1	;
if	tenure	<	4	then	tenure	=	4	;
if	churn	<	0	then	churn	=	0	;
if	longmon	<	2.9	then	longmon	=	2.9	;
if	lnlongmon	<	1.0647107	then	lnlongmon	=	1.0647107	;
if	longten	<	12.575	then	longten	=	12.575	;
if	lnlongten	<	2.5316929	then	lnlongten	=	2.5316929	;
if	tollfree	<	0	then	tollfree	=	0	;
if	tollmon	<	0	then	tollmon	=	0	;
if	lntollmon	<	0	then	lntollmon	=	0	;
if	tollten	<	0	then	tollten	=	0	;
if	lntollten	<	0	then	lntollten	=	0	;
if	equip	<	0	then	equip	=	0	;
if	equipmon	<	0	then	equipmon	=	0	;
if	lnequipmon	<	0	then	lnequipmon	=	0	;
if	equipten	<	0	then	equipten	=	0	;
if	lnequipten	<	0	then	lnequipten	=	0	;
if	callcard	<	0	then	callcard	=	0	;
if	cardmon	<	0	then	cardmon	=	0	;
if	lncardmon	<	0	then	lncardmon	=	0	;
if	cardten	<	0	then	cardten	=	0	;
if	lncardten	<	0	then	lncardten	=	0	;
if	wireless	<	0	then	wireless	=	0	;
if	wiremon	<	0	then	wiremon	=	0	;
if	lnwiremon	<	0	then	lnwiremon	=	0	;
if	wireten	<	0	then	wireten	=	0	;
if	lnwireten	<	0	then	lnwireten	=	0	;
if	multline	<	0	then	multline	=	0	;
if	voice	<	0	then	voice	=	0	;
if	pager	<	0	then	pager	=	0	;
if	internet	<	0	then	internet	=	0	;
if	callid	<	0	then	callid	=	0	;
if	callwait	<	0	then	callwait	=	0	;
if	forward	<	0	then	forward	=	0	;
if	confer	<	0	then	confer	=	0	;
if	ebill	<	0	then	ebill	=	0	;
if	owntv	<	1	then	owntv	=	1	;
if	hourstv	<	12	then	hourstv	=	12	;
if	ownvcr	<	0	then	ownvcr	=	0	;
if	owndvd	<	0	then	owndvd	=	0	;
if	owncd	<	0	then	owncd	=	0	;
if	ownpda	<	0	then	ownpda	=	0	;
if	ownpc	<	0	then	ownpc	=	0	;
if	ownipod	<	0	then	ownipod	=	0	;
if	owngame	<	0	then	owngame	=	0	;
if	ownfax	<	0	then	ownfax	=	0	;
if	news	<	0	then	news	=	0	;
if	response_01	<	0	then	response_01	=	0	;
if	response_02	<	0	then	response_02	=	0	;
if	response_03	<	0	then	response_03	=	0	;
run;

/*checking the normality of dependent variable*/

proc univariate data= LR ;
var Total_Spend;
histogram;
run;

/*Transforming dependent variable to make it normal*/

Data LR;
set LR;
Ln_Total_Spend=log(Total_Spend);
run;

proc univariate data= LR ;
var Total_Spend Ln_Total_Spend ;
histogram;
run;


/*ANOVA TEST TO FILTER UNWANTED CATEGORICAL VARIABLES (Significance level = 95%)*/

proc anova data=LR;
class region	townsize gender	jobcat	union	retire	default	jobsat	marital	
homeown	hometype	cars	carown	cartype	carcatvalue	carbought	carbuy	commute	commutecat	
commutecar	commutemotorcycle	commutecarpool	commutebus	commuterail	commutepublic	
commutebike	commutewalk	commutenonmotor	telecommute	reason	polview	polparty	polcontrib	
vote	card	cardtype	cardbenefit	cardfee	card2	card2type	card2benefit	
card2fee	active	bfast	churn	multline	voice	pager	internet	callid	callwait
forward	confer	ebill	owntv	ownvcr	owndvd	owncd	ownpda	ownpc	ownipod	owngame	ownfax
news	response_01	response_02	response_03	agecat	edcat	inccat	spousedcat	pets_cats	
pets_dogs	pets_birds	pets_reptiles	pets_small	pets_saltfish	pets_freshfish	addresscat	
cardtenurecat	card2tenurecat	callcard	wireless	empcat ;
model ln_Total_spend = region	townsize gender	jobcat	union	retire	default	jobsat	marital	
homeown	hometype	cars	carown	cartype	carcatvalue	carbought	carbuy	commute	commutecat	
commutecar	commutemotorcycle	commutecarpool	commutebus	commuterail	commutepublic	
commutebike	commutewalk	commutenonmotor	telecommute	reason	polview	polparty	polcontrib	
vote	card	cardtype	cardbenefit	cardfee	card2	card2type	card2benefit	
card2fee	active	bfast	churn	multline	voice	pager	internet	callid	callwait
forward	confer	ebill	owntv	ownvcr	owndvd	owncd	ownpda	ownpc	ownipod	owngame	ownfax
news	response_01	response_02	response_03	agecat	edcat	inccat	spousedcat	pets_cats	
pets_dogs	pets_birds	pets_reptiles	pets_small	pets_saltfish	pets_freshfish	addresscat	
cardtenurecat	card2tenurecat	callcard	wireless	empcat; 
run;


/*Performing Stepwise regression on full dataset including continuous & filtered cat. Vars,
at 95 % significance level*/

proc reg data=LR;
model ln_Total_Spend = region	gender	jobcat	union	retire	default	jobsat	marital	homeown	
hometype	cars	carown	cartype	carcatvalue	carbought	carbuy	commute	commutecat	
commutemotorcycle	commutebike	reason	polview	polcontrib	vote	card	cardbenefit	card2	
card2benefit	card2fee	bfast	churn	multline	voice	pager	internet	callid	
callwait	forward	confer	ebill	ownvcr	owndvd	owncd	ownpda	ownpc	ownipod	owngame	
ownfax	news	response_02	response_03	agecat	edcat	inccat	spousedcat	pets_dogs	
pets_freshfish	addresscat	cardtenurecat	card2tenurecat	callcard	wireless	empcat
age	ed	employ	lninc	debtinc	lncreddebt	lnothdebt	spoused	reside	pets	address	
carvalue	cardtenure	card2tenure	tenure	hourstv	commutetime	lnlongmon	lnlongten	tollmon	
tollten	equipmon	equipten	cardmon	cardten	wiremon	wireten	income	creddebt	othdebt	
longmon	longten	tollfree	lntollmon	lntollten	equip	lnequipmon	lnequipten	lncardmon	
lncardten	lnwiremon	lnwireten/selection = stepwise VIF STB ;
run;																					


/* Creating dummy variables */

Data LR;
set LR;
if 	region	=	'1'	then	region_d1	=	1	; else	region_d1	=	0	;
if 	region	=	'2'	then	region_d2	=	1	; else	region_d2	=	0	;
if 	region	=	'3'	then	region_d3	=	1	; else	region_d3	=	0	;
if 	region	=	'4'	then	region_d4	=	1	; else	region_d4	=	0	;
												
if 	edcat	=	'1'	then	edcat_d1	=	1	; else	edcat_d1	=	0	;
if 	edcat	=	'2'	then	edcat_d2	=	1	; else	edcat_d2	=	0	;
if 	edcat	=	'3'	then	edcat_d3	=	1	; else	edcat_d3	=	0	;
if 	edcat	=	'4'	then	edcat_d4	=	1	; else	edcat_d4	=	0	;
												
												
if 	empcat	=	'1'	then	empcat_d1	=	1	; else	empcat_d1	=	0	;
if 	empcat	=	'2'	then	empcat_d2	=	1	; else	empcat_d2	=	0	;
if 	empcat	=	'3'	then	empcat_d3	=	1	; else	empcat_d3	=	0	;
if 	empcat	=	'4'	then	empcat_d4	=	1	; else	empcat_d4	=	0	;
												
if 	inccat	=	'1'	then	inccat_d1	=	1	; else	inccat_d1	=	0	;
if 	inccat	=	'2'	then	inccat_d2	=	1	; else	inccat_d2	=	0	;
if 	inccat	=	'3'	then	inccat_d3	=	1	; else	inccat_d3	=	0	;
if 	inccat	=	'4'	then	inccat_d4	=	1	; else	inccat_d4	=	0	;
												
if 	jobsat	=	'1'	then	jobsat_d1	=	1	; else	jobsat_d1	=	0	;
if 	jobsat	=	'2'	then	jobsat_d2	=	1	; else	jobsat_d2	=	0	;
if 	jobsat	=	'3'	then	jobsat_d3	=	1	; else	jobsat_d3	=	0	;
if 	jobsat	=	'4'	then	jobsat_d4	=	1	; else	jobsat_d4	=	0	;
												
if 	spousedcat	=	'1'	then	spousedcat_d1	=	1	; else	spousedcat_d1	=	0	;
if 	spousedcat	=	'2'	then	spousedcat_d2	=	1	; else	spousedcat_d2	=	0	;
if 	spousedcat	=	'3'	then	spousedcat_d3	=	1	; else	spousedcat_d3	=	0	;
if 	spousedcat	=	'4'	then	spousedcat_d4	=	1	; else	spousedcat_d4	=	0	;
if 	spousedcat	=	'5'	then	spousedcat_d5	=	1	; else	spousedcat_d5	=	0	;
												
if 	addresscat	=	'1'	then	addresscat_d1	=	1	; else	addresscat_d1	=	0	;
if 	addresscat	=	'2'	then	addresscat_d2	=	1	; else	addresscat_d2	=	0	;
if 	addresscat	=	'3'	then	addresscat_d3	=	1	; else	addresscat_d3	=	0	;
if 	addresscat	=	'4'	then	addresscat_d4	=	1	; else	addresscat_d4	=	0	;
												
if 	carown	=	'0'	then	carown_d1	=	1	; else	carown_d1	=	0	;
if 	carown	=	'1'	then	carown_d2	=	1	; else	carown_d2	=	0	;
												
if 	carcatvalue	=	'1'	then	carcatvalue_d1	=	1	; else	carcatvalue_d1	=	0	;
if 	carcatvalue	=	'2'	then	carcatvalue_d2	=	1	; else	carcatvalue_d2	=	0	;
if 	carcatvalue	=	'3'	then	carcatvalue_d3	=	1	; else	carcatvalue_d3	=	0	;
												
if 	card	=	'1'	then	card_d1	=	1	; else	card_d1	=	0	;
if 	card	=	'2'	then	card_d2	=	1	; else	card_d2	=	0	;
if 	card	=	'3'	then	card_d3	=	1	; else	card_d3	=	0	;
if 	card	=	'4'	then	card_d4	=	1	; else	card_d4	=	0	;
												
if 	card2	=	'1'	then	card2_d1	=	1	; else	card2_d1	=	0	;
if 	card2	=	'2'	then	card2_d2	=	1	; else	card2_d2	=	0	;
if 	card2	=	'3'	then	card2_d3	=	1	; else	card2_d3	=	0	;
if 	card2	=	'4'	then	card2_d4	=	1	; else	card2_d4	=	0	;
												
if 	cardtenurecat	=	'1'	then	cardtenurecat_d1	=	1	; else	cardtenurecat_d1	=	0	;
if 	cardtenurecat	=	'2'	then	cardtenurecat_d2	=	1	; else	cardtenurecat_d2	=	0	;
if 	cardtenurecat	=	'3'	then	cardtenurecat_d3	=	1	; else	cardtenurecat_d3	=	0	;
if 	cardtenurecat	=	'4'	then	cardtenurecat_d4	=	1	; else	cardtenurecat_d4	=	0	;
												
if 	card2tenurecat	=	'1'	then	card2tenurecat_d1	=	1	; else	card2tenurecat_d1	=	0	;
if 	card2tenurecat	=	'2'	then	card2tenurecat_d2	=	1	; else	card2tenurecat_d2	=	0	;
if 	card2tenurecat	=	'3'	then	card2tenurecat_d3	=	1	; else	card2tenurecat_d3	=	0	;
if 	card2tenurecat	=	'4'	then	card2tenurecat_d4	=	1	; else	card2tenurecat_d4	=	0	;
												
if 	bfast	=	'1'	then	bfast_d1	=	1	; else	bfast_d1	=	0	;
if 	bfast	=	'2'	then	bfast_d2	=	1	; else	bfast_d2	=	0	;
												
if 	internet	=	'1'	then	internet_d1	=	1	; else	internet_d1	=	0	;
if 	internet	=	'2'	then	internet_d2	=	1	; else	internet_d2	=	0	;
if 	internet	=	'3'	then	internet_d3	=	1	; else	internet_d3	=	0	;
if 	internet	=	'4'	then	internet_d4	=	1	; else	internet_d4	=	0	;
												
if 	hometype	=	'1'	then	hometype_d1	=	1	; else	hometype_d1	=	0	;
if 	hometype	=	'2'	then	hometype_d2	=	1	; else	hometype_d2	=	0	;
if 	hometype	=	'3'	then	hometype_d3	=	1	; else	hometype_d3	=	0	;
												
if 	reason	=	'1'	then	reason_d1	=	1	; else	reason_d1	=	0	;
if 	reason	=	'2'	then	reason_d2	=	1	; else	reason_d2	=	0	;
if 	reason	=	'3'	then	reason_d3	=	1	; else	reason_d3	=	0	;
if 	reason	=	'4'	then	reason_d4	=	1	; else	reason_d4	=	0	;
if 	reason	=	'8'	then	reason_d5	=	1	; else	reason_d5	=	0	;
												
if 	carbought	=	'0'	then	carbought_d1	=	1	; else	carbought_d1	=	0	;
if 	carbought	=	'1'	then	carbought_d2	=	1	; else	carbought_d2	=	0	;
												
if 	jobcat	=	'1'	then	jobcat_d1	=	1	; else	jobcat_d1	=	0	;
if 	jobcat	=	'2'	then	jobcat_d2	=	1	; else	jobcat_d2	=	0	;
if 	jobcat	=	'3'	then	jobcat_d3	=	1	; else	jobcat_d3	=	0	;
if 	jobcat	=	'4'	then	jobcat_d4	=	1	; else	jobcat_d4	=	0	;
if 	jobcat	=	'5'	then	jobcat_d5	=	1	; else	jobcat_d5	=	0	;

if 	cars	=	'1'	then	cars_d1	=	1	; else	cars_d1	=	0	;
if 	cars	=	'2'	then	cars_d2	=	1	; else	cars_d2	=	0	;
if 	cars	=	'3'	then	cars_d3	=	1	; else	cars_d3	=	0	;
if 	cars	=	'4'	then	cars_d4	=	1	; else	cars_d4	=	0	;
if 	cars	=	'5'	then	cars_d5	=	1	; else	cars_d5	=	0	;
if 	cars	=	'6'	then	cars_d6	=	1	; else	cars_d6	=	0	;
if 	cars	=	'7'	then	cars_d7	=	1	; else	cars_d7	=	0	;
if 	cars	=	'8'	then	cars_d8	=	1	; else	cars_d8	=	0	;

run;

proc surveyselect data=LR  out=LR outall samprate=0.7 seed=12345; run;

data dev val;
set LR;
if selected = 1 then output dev;
else output val;
run;

/*Defining Cook's D distance for all relevant variables*/

proc reg data= dev;
model ln_Total_Spend = 
age lninc cardmon wireten creddebt longmon 
region_d1 region_d2 region_d3 region_d4  gender jobsat_d1 jobsat_d2 jobsat_d3 jobsat_d4
jobcat_d1 jobcat_d2 jobcat_d3 jobcat_d4 jobcat_d5 carbought_d1 carbought_d2
card_d1 card_d2 card_d3 card_d4 card2_d1 card2_d2 card2_d3 card2_d4
voice internet_d1 internet_d2 internet_d3 internet_d4 owndvd response_03
cardtenurecat_d1 cardtenurecat_d2 cardtenurecat_d3 cardtenurecat_d4 
/* retire reason_d1 reason_d2 reason_d3 reason_d4 reason_d5   */
/* lnlongten owntv ownvcr  owncd ownpda ownpc ownipod owngame ownfax  */
/* cars_d1 cars_d2 cars_d3 cars_d4 cars_d5 cars_d6 cars_d7 cars_d8 */
/* card2tenure othdebt hometype_d1 hometype_d2 hometype_d3  */
/selection = stepwise VIF STB;
output out=dev1 cookd=D;
run;
data dev1;
set dev1;
where D< (4/3500);
run;


/*ITERATION - 1*/

proc reg data=dev1;
model ln_Total_Spend = 
age lninc cardmon wireten creddebt longmon 
region_d1 region_d2 region_d3 region_d4  gender jobsat_d1 jobsat_d2 jobsat_d3 jobsat_d4
jobcat_d1 jobcat_d2 jobcat_d3 jobcat_d4 jobcat_d5 carbought_d1 carbought_d2
card_d1 card_d2 card_d3 card_d4 card2_d1 card2_d2 card2_d3 card2_d4
voice internet_d1 internet_d2 internet_d3 internet_d4 owndvd response_03
cardtenurecat_d1 cardtenurecat_d2 cardtenurecat_d3 cardtenurecat_d4 
/* retire reason_d1 reason_d2 reason_d3 reason_d4 reason_d5   */
/* lnlongten owntv ownvcr  owncd ownpda ownpc ownipod owngame ownfax  */
/* cars_d1 cars_d2 cars_d3 cars_d4 cars_d5 cars_d6 cars_d7 cars_d8 */
/* card2tenure othdebt hometype_d1 hometype_d2 hometype_d3  */
/ selection = stepwise VIF STB;
run;

/*ITERATION - 2*/

proc reg data=dev1;
model ln_Total_Spend = 
age lninc cardmon wireten creddebt longmon 
 region_d2 region_d3 region_d4  gender jobsat_d1 jobsat_d2 
jobcat_d1 jobcat_d2 jobcat_d3 jobcat_d4 jobcat_d5 carbought_d1 carbought_d2
card_d1 card_d2  card_d4 card2_d1 card2_d2 card2_d3 
voice internet_d1  internet_d3 internet_d4 owndvd response_03
cardtenurecat_d1 cardtenurecat_d2 cardtenurecat_d3 cardtenurecat_d4 
/* jobsat_d3 jobsat_d4 card_d3 card2_d4 internet_d2 region_d1 */
/* retire reason_d1 reason_d2 reason_d3 reason_d4 reason_d5   */
/* lnlongten owntv ownvcr  owncd ownpda ownpc ownipod owngame ownfax  */
/* cars_d1 cars_d2 cars_d3 cars_d4 cars_d5 cars_d6 cars_d7 cars_d8 */
/* card2tenure othdebt hometype_d1 hometype_d2 hometype_d3  */
/ selection = stepwise VIF STB;
output out=dev2 cookd=D2;
run;
data dev2;
set dev2;
where D2< (4/3325);
run;

proc reg data=dev2;
model ln_Total_Spend = 
age lninc cardmon wireten creddebt longmon 
 region_d2 region_d3 region_d4  gender jobsat_d1 jobsat_d2 
jobcat_d1 jobcat_d2 jobcat_d3 jobcat_d4 jobcat_d5 carbought_d1 carbought_d2
card_d1 card_d2  card_d4 card2_d1 card2_d2 card2_d3 
voice internet_d1  internet_d3 internet_d4 owndvd response_03
cardtenurecat_d1 cardtenurecat_d2 cardtenurecat_d3 cardtenurecat_d4 
/* jobsat_d3 jobsat_d4 card_d3 card2_d4 internet_d2 region_d1 */
/* retire reason_d1 reason_d2 reason_d3 reason_d4 reason_d5   */
/* lnlongten owntv ownvcr  owncd ownpda ownpc ownipod owngame ownfax  */
/* cars_d1 cars_d2 cars_d3 cars_d4 cars_d5 cars_d6 cars_d7 cars_d8 */
/* card2tenure othdebt hometype_d1 hometype_d2 hometype_d3  */
/ selection = stepwise VIF STB;
run;

/*ITERATION - 3*/

proc reg data=dev2;
model ln_Total_Spend = 
age lninc cardmon wireten creddebt longmon 
 region_d2 region_d3 region_d4  gender jobsat_d1 jobsat_d2 
jobcat_d1 jobcat_d2 jobcat_d3 jobcat_d4 jobcat_d5 carbought_d1 carbought_d2
card_d1  card2_d1 card2_d2 card2_d3 
voice internet_d1  internet_d3 internet_d4  response_03
cardtenurecat_d1 cardtenurecat_d2 cardtenurecat_d3 cardtenurecat_d4 
/* jobsat_d3 jobsat_d4 card_d3 card2_d4 internet_d2 region_d1 card_d2 card_d4 owndvd */
/* retire reason_d1 reason_d2 reason_d3 reason_d4 reason_d5   */
/* lnlongten owntv ownvcr  owncd ownpda ownpc ownipod owngame ownfax  */
/* cars_d1 cars_d2 cars_d3 cars_d4 cars_d5 cars_d6 cars_d7 cars_d8 */
/* card2tenure othdebt hometype_d1 hometype_d2 hometype_d3  */
/ selection = stepwise VIF STB;
output out=dev3 cookd=D3;
run;
data dev3;
set dev3;
where D3< (4/3190);
run;

proc reg data=dev3;
model ln_Total_Spend = 
age lninc cardmon wireten creddebt longmon 
 region_d2 region_d3 region_d4  gender jobsat_d1 jobsat_d2 
jobcat_d1 jobcat_d2 jobcat_d3 jobcat_d4 jobcat_d5 carbought_d1 carbought_d2
card_d1  card2_d1 card2_d2 card2_d3 
voice internet_d1  internet_d3 internet_d4  response_03
cardtenurecat_d1 cardtenurecat_d2 cardtenurecat_d3 cardtenurecat_d4 
/* jobsat_d3 jobsat_d4 card_d3 card2_d4 internet_d2 region_d1 card_d2 card_d4 owndvd  */
/* retire reason_d1 reason_d2 reason_d3 reason_d4 reason_d5   */
/* lnlongten owntv ownvcr  owncd ownpda ownpc ownipod owngame ownfax  */
/* cars_d1 cars_d2 cars_d3 cars_d4 cars_d5 cars_d6 cars_d7 cars_d8 */
/* card2tenure othdebt hometype_d1 hometype_d2 hometype_d3  */
/ selection = stepwise VIF STB;
run;

/* R-square = 38.51% */

data dev3;
set dev3;
ln_Total_spend = (age	*	-0.00267) + (lninc	*	0.29045) +(creddebt	*	0.01264) +
(longmon	*	0.00307) + (region_d3	*	-0.06579) + (gender	*	-0.05932) + (card_d1	*	0.52403) +
(card2_d1	*	0.34556) + (voice	*	-0.06392) + (cardtenurecat_d3	*	-0.05423) + 4.94257;
Spend = Exp(ln_Total_spend);
run;

proc rank data=dev3 out=dev3 ties=low 
 descending groups=10; 
 var Spend; 
 ranks Decile; 
run; 

ods html file='/folders/myfolders/sample dataset/Linear Regression Case/LR.xls';
proc means data=dev3 ;  
 class Decile; 
 var Total_Spend Spend; 
 output out=report 
 mean=actualavg predicted_avg; 
run; 
ods html close;

/*Validation Dataset*/

data val;
set val;
ln_Total_spend = (age	*	-0.00267) + (lninc	*	0.29045) +(creddebt	*	0.01264) +
(longmon	*	0.00307) + (region_d3	*	-0.06579) + (gender	*	-0.05932) + (card_d1	*	0.52403) +
(card2_d1	*	0.34556) + (voice	*	-0.06392) + (cardtenurecat_d3	*	-0.05423) + 4.94257;
Spend = Exp(ln_Total_spend);
run;

proc rank data=val out=val1 ties=low 
 descending groups=10; 
 var Spend; 
 ranks Decile; 
run; 

ods html file='/folders/myfolders/sample dataset/Linear Regression Case/validation.xls';
proc means data=val1;  
 class Decile; 
 var Total_Spend Spend; 
 output out=report 
 mean=actualavg predicted_avg; 
run; 
ods html close;