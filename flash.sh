adb reboot bootloader
echo for not erase modemst1 and modemst2

DEVICE=$(fastboot getvar device 2>&1 | grep -oiw zangyapro)
PRODUCT=$(fastboot getvar product 2>&1 | grep -o SDM660)

# Set default boot partition to boot_a
fastboot set_active a
# fastboot flash partition gpt_both0.bin
fastboot flash bluetooth_a BTFM.bin
fastboot flash bluetooth_b BTFM.bin
fastboot flash devcfg_a devcfg.mbn
fastboot flash devcfg_b devcfg.mbn
fastboot flash dsp_a dspso.bin
fastboot flash dsp_b dspso.bin
fastboot flash --slot all modem NON-HLOS.bin
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

# fastboot flash fsg fs_image.tar.gz.mbn.img
# fastboot flash modemst1 dummy.bin
# fastboot flash modemst2 dummy.bin
# fastboot flash persist persist.img
# fastboot flash sec sec.dat

fastboot erase misc
fastboot erase frp
fastboot erase splash

fastboot flash abl_a abl.elf
fastboot flash abl_b abl.elf
fastboot flash --slot all boot boot.img
fastboot flash system system.img

if [ ! -f system_other.img ]; then
	fastboot flash --slot other system system.img
else
	echo "System Odex Image found!"
	fastboot flash --slot other system system_other.img
fi

fastboot flash vendor_a vendor.img
fastboot flash vendor_b vendor.img
fastboot flash userdata userdata.img
fastboot flash mdtp_a mdtp.img
fastboot flash mdtp_b mdtp.img
else
	echo -n Device does not match zangyapro and cannot be flashed. Check the FW.
fi

fastboot reboot
