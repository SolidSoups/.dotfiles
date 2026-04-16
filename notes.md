Based on your current Fedora 43 setup, here's how to replicate it:                                
                                                                                                    
  1. Enable RPM Fusion (if not already):                                                            
  sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E        
  %fedora).noarch.rpm                                                                               
  sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E  
  %fedora).noarch.rpm                                                                               
                                                                                                    
  2. Install xone packages:                                                                         
  sudo dnf install akmod-xone xone-firmware                                                         
                                           
  3. Install the proprietary firmware (requires accepting license):                                 
  sudo dnf install lpf-xone-firmware                                                                
  lpf approve xone-firmware                                                                         
  sudo lpf build xone-firmware                                                                      
  sudo lpf install xone-firmware                                                                    
                                
  4. Rebuild kernel modules and load:                                                               
  sudo akmods --force                                                                               
  sudo modprobe xone-dongle
                                                                                                    
  5. Reboot — modules should load automatically after that.                                         
                                                                                                    
  ---                                                                                               
  A few notes:                                                                                      
  - The akmod package auto-rebuilds the driver whenever the kernel updates, so you don't have to
  redo this.                                                                                    
  - Plug in the Xbox wireless dongle after rebooting.                                               
  - If the other laptop is running a different distro, the process differs — let me know and I can
  give distro-specific steps.
