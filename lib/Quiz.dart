class Quiz {
   int _id  ;
   String _question ;


   Quiz( this._id , this._question );

   set question(String value) {
     _question = value;
   }

   set id(int value) {
     _id = value;
   }

   String get question => _question;

   int get id => _id;

   @override
  String toString() => question ;
}