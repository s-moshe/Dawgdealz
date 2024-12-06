Team Name: DawgDealz:

Auditor Name: Hana Chohan

Commit id: 2122836d

Date/Place of audit: Early morning of Dec 5, CSE2.

Devices and settings used: Iphone, TalkBack in Accessibility settings

Strengths of the app: The DawgDeals app demonstrates several strengths, making it user-friendly and accessible. Features like clear forms for registration and login, including automatic @uw.edu email formatting, ensure ease of use. The app incorporates accessibility elements, such as the Semantics widget for screen readers and instant feedback through SnackBar messages, enhancing inclusivity. A cohesive design language is maintained, with consistent styles for buttons and pages. Usability is further improved by thoughtful features like "Preferred Campus Meetup Spots" and user-friendly item listings. Error prevention mechanisms, such as validating input fields, reduce user frustration. Security is also prioritized with obfuscated password inputs in login and signup forms, protecting user information. Overall, DawgDeals effectively balances design, functionality, and accessibility to create a seamless user experience.


Weakness #1: Contrast

Name/Brief Description - Low contrast between button color and app background. 

Testing Method - WebAim contrast checker

Evidence - 

![img desc](https://cdn.discordapp.com/attachments/888691546982064188/1314457901355765830/image.png?ex=6753d7d1&is=67528651&hm=7932f479bca3434257517a4a42e4805e9f8b48aac66511ae668ce622de823061&)

![img desc](https://cdn.discordapp.com/attachments/888691546982064188/1314458335512232077/image.png?ex=6753d838&is=675286b8&hm=505188d2e9d3f2246c21202c75d958e3c4f0dfe0342a1967e7afbbeb974f0f98&)


Many of the buttons throughout the app are light colored against a pale background, providing little contrast. This lowers the perceivablity of the buttons, especially for users with low vision. For example, the home page has pale pink buttons against a white button, which has a contrast ratio of 2.69:1. While the currently selected button does have a darker button color as an indication, the other buttons don’t have anything to make them stand out. This creates issues because users who are not able to perceive the other buttons clearly will not be able to navigate to the other pages. Other buttons throughout the also have a similar design, such as the buttons on the log in, account view, and seller profile view being pale lavender against a pale pink background, which yet again falls short of the required minimum on 3:1 to meet accessibility standards. Overall, this issue violates WCAG 1.4.11 which is the guideline for non-text contrast. 

2 - Minor: Low Priority

Justification:

Frequency: This issue is consistent across all buttons with a light pink background, making it relatively common within the interface.

Impact: While the text is still somewhat legible, users with visual impairments or those in bright lighting conditions may struggle to read the text easily.

Persistence: The issue is persistent, as the contrast ratio will always remain below the acceptable threshold unless users enable high contrast mode in the accessibility settings of their phone. However, not all phones may have this so this workaround is not sufficient.

Possible solution:

Adjust the Background Color: Modify the light pink button background to a slightly darker or more saturated shade to create sufficient contrast with the white background.




Weakness #2: Visual Content & Alt Text

Name/Brief Description - A non-visual alternative to the images is not being communicated by the screen reader.

Testing Method - Screenreader

Evidence - 
When focusing on the cards on the home screen, the screen reader does not read out any semantic label for the images inside the item cards. Instead the screen reader only says “image”, but you have no idea what the image actually is because there is no alt text so users who have low vision or rely on screenreachers will not have the necessary context to navigate the home page and confidently purchase items on DawgDealz. This violates WCAG 1.1.1 which requires that information conveyed by non-text content is made accessible through the use of a text alternative.

3 - Major: High Priority

Justification:

Frequency: This issue is consistent across all the cards on the home page, since they all have images where sellers can showcase their items visually.

Impact: This has a moderate - high impact because users with low vision may experience confusion when the screen reader does not provide any details for what the image actually is. However, there is an image description for the item, but users would have to click on the card and open a separate view solely for the listing description to access this.

Persistence: The issue is somewhat persistent because there is no easy way to work around this problem using only a screen reader on the home page. Users would have to go through an extra stem of opening the listing description.

Possible solution:
Wrap the card in a Semantics widget with a label for the image!
