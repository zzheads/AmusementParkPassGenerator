#[Amusement Park Pass Generator](https://teamtreehouse.com/projects/amusement-park-pass-generator-part-2)
###by Alexey Papin
<img width="400"src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRGazv7ZhZ82KHNshlU26qJnlPcO0cnzgBBhTZcdxy5MLNKUgkH">

[![Latest Stable Version](https://poser.pugx.org/edward/aaa/v/stable)](https://packagist.org/packages/edward/aaa)

###About this Course

You will now take the code you created in Project 4 (Amusement Park Generator: Part 1) and add User Interface, along with a short list of new features and entrant types. These changes may force you to refactor some code in order to accommodate them.
Upon completion, you will have an app, created entirely yourself, which can take user input, create personalized entrant passes for a variety of entrant types as well as test their “swipe-ability” at various locations.

- [ ] App layout (on all screens) is closely aligned to mockups provided
- [ ] App presents and hides view or view elements appropriately.
- [ ] Passes are created correctly, based on required information. For Vendors and Contractors, only those Project Numbers and Vendor Companies listed in the Entrant Access Rules should be accepted.
- [ ] Makes use of protocols and inheritance such that code is clean and (somewhat) extensible
- [ ] Uses enums for Error types, Mgr. Types, Emp. Types, Vendors or Guest Types
`Makes use of associated values for cleaner or more elegant code.`
- [ ] Errors are created using enums, are thrown at appropriate times and carry informative messages.
- [ ] Creates one or more swipe methods to handle access to areas, rides, skips and discounts. Methods should return bools, or appropriate results, not throw errors when access is denied.
`Makes use of clever polymorphic or dynamic code for highly reusable swiping.`
- [ ] Correctly grants access to Vendors and Contractors based on Entrant Access Rules provided.
- [ ] Creates (and comments out) a complete set of plug values such that all entrant types and most errors can be tested.
`Creates a truly exhaustive set of plug values which allows for testing of all entrant types and ALL reasonable error paths`
- [ ] Uses expressive variable/method names and sufficiently descriptive comments.
- [ ] Code is available on GitHub, is free of errors and compiles.
- [ ] `Student successfully implemented input validation.`
 

>Create entry passes for the seven entrant types listed in Project 3 (Classic, VIP, Free Child, Hourly Employee - Food, Hourly Employee Maintenance, Manager)

>Create entry passes for the four additional entrant types listed in Project 4 (Season Pass Guest, Senior Guest, Contract Employee, Vendor)

>Ensure that all necessary information is present before issuing a particular type of pass - if not, display appropriate message

>Test the pass for entry to various areas (Amusement, Ride, Kitchen, Maintenance, Office)

>Test the pass for ride access

>Test the pass for line skipping

>Test the pass for discounts on food and merchandise

>Still satisfy all code requirements from Project 4

>####NOTE: To get an "exceeds" rating, you should implement the following input validation feature, marked as “extra credit” in the rubric, and earn "exceeds" ratings for all of the other requirements where an “exceeds” rating is shown (App Layout, Enumerations,"Swipe" methods, Plug Values).
>Add additional text validation to ensure that phone numbers and zip codes are all numerical and that all text entries are of “reasonable” length. You can decide what you deem reasonable, simply describe in a code comment. You will only be graded on the implementation.
