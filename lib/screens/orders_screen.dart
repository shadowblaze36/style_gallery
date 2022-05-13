import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style_gallery/providers/providers.dart';
import 'package:style_gallery/services/services.dart';
import 'package:style_gallery/widgets/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Form(
            key: myFormKey,
            child: Column(
              children: [
                //_CustomDropDown(ordersProvider: ordersProvider),
                const SizedBox(height: 10),
                _SearchField(
                    myFormKey: myFormKey, ordersProvider: ordersProvider),
                const SizedBox(height: 5),
                _SearchButton(
                    myFormKey: myFormKey, ordersProvider: ordersProvider),
                ordersProvider.resultCode != 200 && ordersProvider.order != ''
                    ? const Text('No se encontraron imagenes',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                    : const ImageGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({
    Key? key,
    required this.myFormKey,
    required this.ordersProvider,
  }) : super(key: key);

  final GlobalKey<FormState> myFormKey;
  final OrdersProvider ordersProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //FocusScope.of(context).requestFocus(FocusNode());
        if (!myFormKey.currentState!.validate()) {
          print('formulario no valido');
        } else {
          await ordersProvider.getContents();
          if (ordersProvider.resultCode == 200) {
          } else {
            NotificationsService.showSnackbar('No se encontraron imagenes');
          }
        }
      },
      child: const SizedBox(
        width: double.infinity,
        child: Center(child: Text('Search')),
      ),
    );
  }
}

class _CustomDropDown extends StatelessWidget {
  const _CustomDropDown({
    Key? key,
    required this.ordersProvider,
  }) : super(key: key);

  final OrdersProvider ordersProvider;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('Search Type'),
      value: 'Order',
      items: const [
        DropdownMenuItem(value: 'Order', child: Text('Order')),
        DropdownMenuItem(value: 'PO Number', child: Text('PO Number')),
        DropdownMenuItem(value: 'MO Number', child: Text('MO Number')),
        DropdownMenuItem(value: 'MO Serial', child: Text('MO Serial'))
      ],
      onChanged: (value) {
        print(value);

        ordersProvider.searchType = value!;
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    Key? key,
    required this.myFormKey,
    required this.ordersProvider,
  }) : super(key: key);

  final GlobalKey<FormState> myFormKey;
  final OrdersProvider ordersProvider;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (_) async {
        if (!myFormKey.currentState!.validate()) {
          print('formulario no valido');
        } else {
          await ordersProvider.getContents();
          if (ordersProvider.resultCode == 200) {
          } else {
            NotificationsService.showSnackbar('No se encontraron imagenes');
          }
        }
      },
      onChanged: (value) {
        ordersProvider.order = value;
      },
      validator: (value) {
        if (value == null) return 'Este campo es requerido';
        return value.length < 3 ? 'Minimo de 3 letras' : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: ordersProvider.searchType,
        hintText: ordersProvider.searchType,
      ),
    );
  }
}
