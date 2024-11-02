- https://swisskyrepo.github.io/InternalAllTheThings/active-directory/ad-adcs-certificate-services/
- https://swisskyrepo.github.io/InternalAllTheThings/active-directory/pwd-group-policy-preferences/#references
	- Install this: https://learn.microsoft.com/en-us/security-updates/SecurityBulletins/2014/ms14-025
	- Check `\\<DOMAIN>\SYSVOL\<DOMAIN>\Policies\` for xml files containing passwords
- Verify Domain Trusts
```powershell
([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()
```
- Patch AMSI bypass?
- Update password policy
- Prevent ASREP Roasting
```powershell
# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users in the domain
$users = Get-ADUser -Filter *

# Iterate through each user
foreach ($user in $users) {
    # Get the user's current UserAccountControl flags
    $userAccountControl = $user.UserAccountControl

    # Remove the DONT_REQ_PREAUTH flag (0x40000)
    $newUserAccountControl = $userAccountControl -band -bnot 0x40000

    # Update the user's UserAccountControl attribute
    if ($newUserAccountControl -ne $userAccountControl) {
        Set-ADUser -Identity $user -UserAccountControl $newUserAccountControl
    }
}
```
- No need to worry about Kerberroasting as long as we have strong passwords
- Set Kerberos password encryption method to [AES256_HMAC_SHA1](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/installing_trust_between_idm_and_ad/ensuring-support-for-common-encryption-types-in-ad-and-rhel_installing-trust-between-idm-and-ad#enabling-the-aes-encryption-type-in-active-directory-using-a-gpo_ensuring-support-for-common-encryption-types-in-ad-and-rhel)
- Check for clock skew
- https://swisskyrepo.github.io/InternalAllTheThings/active-directory/internal-mitm-relay/#smb-signing-disabled-and-ipv4
	- Disable LLMNR via group policy
		- `Open gpedit.msc and navigate to Computer Configuration > Administrative Templates > Network > DNS Client > Turn off multicast name resolution and set to Enabled`
	- Disable NBT-NS
		- `This can be achieved by navigating through the GUI to Network card > Properties > IPv4 > Advanced > WINS and then under "NetBIOS setting" select Disable NetBIOS over TCP/IP`
- Whatever the fuck this is: https://swisskyrepo.github.io/InternalAllTheThings/active-directory/ad-adcs-certificate-services/
- https://swisskyrepo.github.io/InternalAllTheThings/active-directory/ad-integrated-dns/
- Check user comments for any dumb shit