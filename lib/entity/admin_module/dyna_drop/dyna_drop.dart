import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class DropdownItem extends ChangeNotifier {
  final String name;

  DropdownItem(this.name);
}

class DropdownList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<DropdownItem>>(context);
    return DropdownButton(
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.name),
        );
      }).toList(),
      onChanged: (value) {
        // Do something when the user selects an item from the dropdown list
      },
    );
  }
}

class dyna_drop extends StatefulWidget {
  const dyna_drop({super.key});

  @override
  State<dyna_drop> createState() => _dyna_dropState();
}

class _dyna_dropState extends State<dyna_drop> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newItem = DropdownItem(_nameController.text);
                final items =
                    Provider.of<List<DropdownItem>>(context, listen: false);
                items.add(newItem);
                _nameController.clear();
              }
            },
            child: Text('Add Item'),
          ),
        ],
      ),
    );
  }
}

class DropdownListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    /*return ChangeNotifierProvider<DropdownItem>(
      create: (context) => List<DropdownItem>[],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown List'),
        ),
        body: Column(
          children: [
            Expanded(child: DropdownList()),
            dyna_drop(),
          ],
        ),
      ),
    );*/
  }
}
