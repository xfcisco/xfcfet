from libc.stdio cimport printf;
from subprocess import check_output as system;
from sys import argv;
from os import getenv;
DEF BANNER_OFFSET = 1;


cdef main(str PictureSize):
    cdef list infoList = []
    cdef str banner = system(['/usr/bin/chafa', argv[1], PictureSize]).decode('utf-8');
    cdef size_t banner_size = len(banner.split('\n'));
    cdef size_t i;
    for _ in range(banner_size-1):
        infoList.append(' ');
    
    cdef dict info = SysInfo(infoList);

    cdef str key;
    cdef unicode COLORS_BAR1 = u'  ';
    cdef unicode COLORS_BAR2 = u'  ';

    for i in range(40, 50):   COLORS_BAR1 += unicode(f"\033[{i}m   \033[00m");
    for i in range(100, 140): COLORS_BAR2 += unicode(f"\033[{i}m   \033[00m");

    i = 0
    for key in info:
        infoList[i] = '  \033[32m\033[1m' + key + '\033[33m ➔ \033[00m ' + info[key];
        i+=1;

    cdef str artist;
    cdef str album;
    cdef str song;
    try:
        artist = system(['playerctl', '-p', 'spotify', 'metadata', 'artist']).decode('utf-8')[0:-1];
        album  = system(['playerctl', '-p', 'spotify', 'metadata', 'album']).decode('utf-8')[0:-1];
        song   = system(['playerctl', '-p', 'spotify', 'metadata', 'title']).decode('utf-8')[0:-1];
    except:
        artist = '- ';
        album  = ' - ';
        song   = '  - ';



    infoList[-6] = '  \033[32m\033[1mArtist\033[33m ➔ \033[00m ' + artist;
    infoList[-5] = '  \033[32m\033[1mAlbum\033[33m ➔ \033[00m ' + album;
    infoList[-4] = '  \033[32m\033[1mSong\033[33m ➔ \033[00m ' + song;
     
    infoList[-7] = '  -------------------------';
    infoList[-2] = COLORS_BAR1;
    infoList[-1] = COLORS_BAR2;
   
   
    ShowBanner(banner, infoList)


cdef void ShowBanner(str banner, list text):
    cdef list banner_list = banner.split('\n');

    if (len(banner_list) < len(text)):
        print("ERROR: the text given to the banner_list is greater than the banner");
        exit();
    
    cdef size_t i;
    for i in range(len(text)):
        banner_list[i] += text[i];
    
    for i in range(len(banner_list)-BANNER_OFFSET):
        print(banner_list[i]);


cdef dict SysInfo(list infoList):
    cdef dict info = {};
    cdef str distro = system(['lsb_release', '-d']).decode('utf-8').strip('Description:')[1:-1];
    cdef str name   = system(['whoami']).decode('utf-8')[0:-1];
    cdef str uptime = system(['uptime', '-p']).decode('utf-8')[0:-1];
    cdef str shell  = getenv('SHELL')
    cdef str de     = getenv('DESKTOP_SESSION');
    cdef str wm     = system(['whoami']).decode('utf-8')[0:-1];
    cdef str term   = getenv('TERM');
    cdef str arch   = system(['uname', '-m']).decode('utf-8')[0:-1];
    cdef str kern   = system(['uname', '-r']).decode('utf-8')[0:-1];

    info['Distro']   = distro;
    info['Kernel']   = kern;
    info['Name']     = name;
    info['Uptime']   = uptime;
    info['Shell']    = shell;
    info['DE']       = de;
    info['Terminal'] = term;
    info['Arch']     = arch;
    return info;

try:
    main("--size=30x30");
except:
    try:
        main("--size=50x50");
    except:
        try:
            main("--size=150x150")
        except:
            print(" something isnt right.\n"\
                  " check the size of the picture you are using it might be too small, try a bigger picture\n"\
                  " if that doesn't work out then check if you have chafa installed\n"\
                  "    chafa install:\n"\
                  "       arch: yay/pacman -S chafa\n"\
                  "       debian: sudo apt-get install chafa\n"
                  " if you are using something else then try to google it.\n");
            exit(1);
