{config, pkgs, lib, ...}:

{
        home.username = "azevedo";
        home.homeDirectory = "/home/azevedo";
        home.stateVersion = "23.05";
        home.packages = [ ];

        home.file = {};
        
        xdg.mimeApps.defaultApplications = {
            "text/plain" = [ "neovim.desktop" ];
            "application/pdf" = [ "zathura.desktop" ];
        };

        programs.git = {
            enable = true;
            userName  = "João Azevedo";
            userEmail = "62391524+Azeved00@users.noreply.github.com";

            extraConfig = {
                advice = {
                    addIgnoredFile = false;
                };
                fetch = {
                    prune = true;
                };
                diff = {
                    colorMoved = "zebra";
                };
                core =  {
                    editor = "nvim";
                    autocrlf = false;
                };
                init = {
                    defaultBranch = "main";
                };
                pull = {
                    rebase = false;
                };
                push = {
                    autoSetupRemote = true;
                };
            };
        };

        programs.bash = {
            enable = true;

            shellAliases = {
                "reload"="source ~/.bashrc";

                "mysql"="mysql -u root -p";
            
                "ls" = "ls --colo=auto";
                "ll" = "ls -l";
                "la" = "ls -la";

                ".." = "cd ..";
                "."  = "ls .";
                "..." = "cd ../../";

                "ga" = "git add";
                "gs" = "git status";
                "gp" = "git push";
                "gf" = "git fetch && git pull && git fetch";
                "gc" = "git commit -m";
                "gsmod" = "git submodule sync && git submodule update --init --recursive";
                
                "dotfiles"="ranger ~/.files/";
            };

            profileExtra = "";
            
            initExtra = ''
                eval $(ssh-agent)
                YELLOW='\[\e[1;33m\]'
                GREY='\[\e[0;37m\]'
                PS1="$YELLOW\t \W > $GREY"
            '';

            bashrcExtra = "";

            shellOptions = [
                "histappend"    # append to history file, dont overwrite it
                "checkwinsize"  # checkwindow size after each command
                "nocaseglob"    # case insensitive globbing
                "cdspell"       # autocorrect typos in path names in cd
            ];

            sessionVariables = {
                CLICOLOR = "1";
                LSCOLORS = "gxfxcxdxbxegedabagacad";

                GREP_OPTIONS = "-color=auto";
                HISTCONTROL="ignoreboth";
                TERMINAL = "alacritty";
            }; 

            historySize = 2000;
            historyFileSize = 10000;
        };
        
        programs.neovim = {
            enable = true;
            defaultEditor = true;
        };

        programs.readline = {
            enable = true;
            bindings = {
                "\\e[Z" = "menu-complete";
                "\\e[A" = "history-search-backward";
                "\\e[B" = "history-search-forward";
            };
            variables = {
                completion-ignore-case = true;
                show-all-if-ambiguous = true;
            };
        };

        programs.ssh = {
            enable = true;

            matchBlocks = {
                "github.com" = {
                    hostname = "github.com";
                    user="git";
                    identityFile = "~/.ssh/main";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };

                "second" = {
                    hostname = "github.com";
                    user = "git";
                    identityFile="~/.ssh/second";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };

                "gitlab" = {
                    hostname = "gitedu.alunos.dcc.fc.up.pt";
                    user = "git";
                    identityFile="~/.ssh/gitlab";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };
            };
        };
        
        programs.alacritty = {
            enable = true;
            
            settings = {
                window = {
                    padding.x = 10;
                    padding.y = 5;
                    opacity   = 1.0;
                    class.instance = "Alacritty";
                    class.general  = "Alacritty";
                };

                scrolling = {
                    history = 10000;
                    multiplier = 3;
                };

                font.size = 13.0;

                colors = {
                    primary = {
                        background = "0x262626";
                        foreground = "0xEBEBEB";
                    };
                    cursor = {
                        text    ="0xEBEBEB";
                        cursor  ="0xEBEBEB";
                    };
                    normal = {
                        black   ="0x0d0d0d";
                        red     ="0xFF301B";
                        green   ="0xA0E521";
                        yellow  ="0xFFC620";
                        blue    ="0x1BA6FA";
                        magenta ="0x8763B8";
                        cyan    ="0x21DEEF";
                        white   ="0xEBEBEB";
                    };
                    bright = {
                        black   ="0x6D7070";
                        red     ="0xFF4352";
                        green   ="0xB8E466";
                        yellow  ="0xFFD750";
                        blue    ="0x1BA6FA";
                        magenta ="0xA578EA";
                        cyan    ="0x73FBF1";
                        white   ="0xFEFEF8";
                    };
                };
                
                cursor = {
                    style = "Beam";
                    blinking = "On";
                    blink_interval = 750;
                };

                draw_bold_text_with_bright_colors = true;
                live_config_reload = true;
                #working_directory = "/users/azevedo/";
            };
        };

        services.picom = {
            enable = true;
            backend = "xrender";
            vSync = true;

            shadow = true;
            shadowExclude = [
                "name = 'Notification'"
                "class_g = 'Conky'"
                "class_g ?= 'Notify-osd'"
                "class_g = 'Cairo-clock'"
                "_GTK_FRAME_EXTENTS@:c"
            ];

            fade = true;
            fadeSteps = [0.03 0.03];
        
            inactiveOpacity = 1;
            opacityRules = [
                "100:name *= 'Picture'"
            ];

            wintypes = {
                tooltip = { 
                    fade = true; 
                    shadow = true; 
                    opacity = 0.75; 
                    focus = true; 
                    full-shadow = false; 
                };
                dock = { shadow = false; };
                dnd = { shadow = false; };
                popup_menu = { opacity = 0.8; };
                dropdown_menu = { opacity = 0.8; };
            };


            settings = {
                shadow-offset-x = -7;
                shadow-offset-y = -7;
                frame-opacity = 0.7;
                inactive-opacity-override = false;
                focus-exclude = ["class_g = 'Cairo-clock'"];
                corner-radius = 0;
                #blur-kern = "3z3box";
                blur-background-exclude = [
                  "window_type = 'dock'"
                  "window_type = 'desktop'"
                  "_GTK_FRAME_EXTENTS@:c"
                ];

                mark-wmwin-focused = true;
                mark-ovredir-focused = true;
                detect-rounded-corners = true;
                detect-client-opacity = true;
                detect-trasient = true;
                detect-client-leader = true;
                use-damage = true;
                log-level = "warn";
                
            };
        };

        programs.home-manager.enable = true;
}