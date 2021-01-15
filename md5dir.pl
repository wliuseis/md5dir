#!/usr/bin/perl -w
#######################################################
#  A simple script to generate MD5 checksums of all
#  the files in a given directory.
#
# Usage:
#   perl ./md5dir.pl DIRECTORY
#
# MD5 checksums of all the files in DIRECTORY will be
# generated in a file named "DIRECTORY.md5".
#
# Notice:
#   Run error when files contain spaces or special
#   characters (such as "&").
#
# By: Wei Liu
# Contact: wliu92@mail.ustc.edu.cn
# Date: 2021.01.14
#######################################################

(@ARGV == 1) or die "$0 DIRECTORY\n";
($maindir)=@ARGV;

$homedir=`pwd`; chomp($homedir);

$md5file="$homedir/$maindir.md5";

system("> $md5file");

&md5dir($maindir,$md5file);


##### subroutine to recursion
sub md5dir {
  my($dir,$md5file)=@_;
  my(@junks);
  my($subdir);
  if(!-d $dir){
    system("md5sum $dir >> $md5file");
  }else{
    @junks=`ls -A $dir`;
    foreach $subdir (@junks) {
      chomp($subdir);
      $subdir="$dir/$subdir";
      &md5dir($subdir,$md5file);
    }
  }
  return 1;
}
