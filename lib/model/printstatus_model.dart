class Printed {
  var id;
  var statusName;

  Printed({
    this.id,
    this.statusName,
  });

  static final printed = [
    Printed(id: 'all', statusName: 'ทั้งหมด'),
    Printed(id: '0', statusName: 'ยังไม่พิมพ์'),
    Printed(id: '1', statusName: 'พิมพ์แล้ว'),
  ];
}
