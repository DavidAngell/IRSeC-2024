- https://swisskyrepo.github.io/InternalAllTheThings/active-directory/ad-adcs-certificate-services/
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
- Whatever the fuck this is: https://swisskyrepo.github.io/InternalAllTheThings/active-directory/ad-adcs-certificate-services/
- https://swisskyrepo.github.io/InternalAllTheThings/active-directory/ad-integrated-dns/