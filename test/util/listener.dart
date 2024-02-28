///Listener to keep track of previous and next states that come from
///notifiers while using Fakes. Feel free to change any of the implementation,
///to fit your needs.
class Listener<Data> {
  //Records previous and next states
  final List<ListenerData<Data>> _data = [];

  void call(Data? previous, Data next) {
    _data.add(ListenerData(next, previous));
  }

  List<ListenerData> get data => _data;
}

///Data class to hold states that come from the [Listener]
class ListenerData<Data> {
  const ListenerData(this.value, this.previousValue);

  final Data value;
  final Data? previousValue;
}
