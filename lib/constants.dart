const List<String> districts = <String>[
  'بورفؤاد',
  'حي الزهور',
  'حي الضواحي',
  'حي المناخ',
  'حي الشرق',
  'حي العرب',
  'الحي الإماراتي',
];

const List<String> orderNatures = [
  'ملابس',
  'اكسسوار',
  'منظفات وورقيات',
  'مكياج',
  'أطعمة',
  'أخرى',
];

enum OrderTypes { personal, commercial }

RegExp phoneRegExp = RegExp(r'^[0-9\u0660-\u0669]{11}$');
RegExp phoneRegExp2 =
    RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');
