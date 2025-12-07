This POC illustrates how multiple environments having a repo each in a Terraform context can be combined into one.

```
Folder PATH listing for volume Windows
Volume serial number is A8F5-8347
C:.
├───mono
│   ├───modules
│   ├───non_prod
│   └───prod
├───non_prod
└───prod
```
`non_prod` and `prod` folders contain the legacy repositories.
`mono` contains the improved approach where modules can achieve true reusability, whilst maintaining the code separation and blast radius of the legacy approach.