clear all
set maxvar 30000
set more off

version 8
set mem 1000m
set matsize 1000

sysuse auto, clear
set scheme s2color

global base_folder "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation"
global data "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Data"
global crosswalk "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Crosswalk"
global workplace "/Users/tallonhowie/Documents/Housing_Constraints_and_Spatial_Misallocation/Workplace"

*1986-2019 using HM MSA's
do $workplace/County_MSA_MorettiHseih /*Organize crosswalk*/
do $workplace/Replicate_CBP_MorretiHseih /*Compare accuracy*/
do $workplace/acs_clean /*Average worker characteristics, rent, comparison, and merge regulations*/
*do $workplace/dist_decomp_REP /*Runs all exercises*/

*1986-2019 using CMSA
do $workplace/County_MSA_NEW
do $workplace/Replication_CBP_NEW
do $workplace/acs_clean_NEW
*do $workplace/dist_decomp_REP_new /*Runs all exercises*/
