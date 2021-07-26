# TaskAnswer
Appentus Flutter Test Answer



The Above project code has a login and registration screen , after user succesfully register or logged in to the app. He/she will be display a list of cards having name and image in Grid View with custom height and Width.




------------------------------------------------------------------------------------------------------------------------------------------------------


Q. Given the following widget called inside second screen:

class MyWidget extends StatelessWidget {
  final personNextToMe = 'That reminds me about the time when I was ten and our neighbor, her name was Mrs. Mable, and she said...';

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.airline_seat_legroom_reduced),
      Text(personNextToMe),
      Icon(Icons.airline_seat_legroom_reduced),
    ]);
  }
}


Ans. Expanded(
  child: Text(
    personNextToMe,
  ),
),


------------------------------------------------------------------------------------------------------------------------------------------------------

Q. class Recipe {
  int cows;
  int trampolines;

  Recipe(this.cows, this.trampolines);
  
  int makeMilkshake() {
    return cows + trampolines;
  }
}

Convert makeMilkshake() to a getter called milkshake using the shorthand “fat arrow” syntax.


Ans. 

int get milkshake => cows + trampolines;



------------------------------------------------------------------------------------------------------------------------------------------------------
