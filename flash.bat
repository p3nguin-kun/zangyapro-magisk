@echo off
adb reboot bootloader
for /f "tokens=2 delims=: " %%a in ('fastboot.exe getvar build_id 2^>^&1 ^| findstr build_id') do set build_id=%%a
if "%build_id%"=="" (goto :Old_Way) else (goto :Check_Device)

:Flash
echo for not erase modemst1 and modemst2
fastboot set_active _a
rem fastboot flash partition gpt_both0.bin
fastboot flash bluetooth_a BTFM.bin
fastboot flash bluetooth_b BTFM.bin
fastboot flash devcfg_a devcfg.mbn
fastboot flash devcfg_b devcfg.mbn
fastboot flash dsp_a dspso.bin
fastboot flash dsp_b dspso.bin
fastboot flash modem_a NON-HLOS.bin
fastboot flash modem_b NON-HLOS.bin
fastboot flash xbl_a xbl.elf
fastboot flash xbl_b xbl.elf
fastboot flash pmic_a pmic.elf
fastboot flash pmic_b pmic.elf
fastboot flash rpm_a rpm.mbn
fastboot flash rpm_b rpm.mbn
fastboot flash tz_a tz.mbn
fastboot flash tz_b tz.mbn
fastboot flash hyp_a hyp.mbn
fastboot flash hyp_b hyp.mbn
fastboot flash keymaster_a keymaster64.mbn
fastboot flash keymaster_b keymaster64.mbn
fastboot flash cmnlib_a cmnlib.mbn
fastboot flash cmnlib_b cmnlib.mbn
fastboot flash cmnlib64_a cmnlib64.mbn
fastboot flash cmnlib64_b cmnlib64.mbn

rem fastboot flash fsg fs_image.tar.gz.mbn.img
rem fastboot flash modemst1 dummy.bin
rem fastboot flash modemst2 dummy.bin
rem fastboot flash persist persist.img
rem fastboot flash sec sec.dat

fastboot erase misc
fastboot erase frp
fastboot erase splash

fastboot flash abl_a abl.elf
fastboot flash abl_b abl.elf
fastboot flash boot_a boot.img
fastboot flash boot_b boot.img
fastboot flash system_a system.img
If NOT exist "system_other.img" (
    fastboot flash system_b system.img
) ELSE (
    echo System Odex Image found!
    fastboot flash system_b system_other.img
)
fastboot flash vendor_a vendor.img
fastboot flash vendor_b vendor.img
fastboot flash userdata userdata.img
fastboot flash mdtp_a mdtp.img
fastboot flash mdtp_b mdtp.img

fastboot reboot
pause
exit

:Error
echo Device does not match zangyapro and cannot be flashed. Check the FW.
pause
exit
