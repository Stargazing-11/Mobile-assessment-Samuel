import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function removeItem;

  const CartItemWidget(
      {super.key, required this.cartItem, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).indicatorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeItem(cartItem.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            leading: cartItem.imageUrl != null
                ? Image.network(
                    cartItem.imageUrl!,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const CircularProgressIndicator();
                    },
                    width: 50,
                    height: 50,
                  )
                : null,
            title: Text(cartItem.title),
            subtitle: Text('Total: \$${cartItem.price * cartItem.quantity}'),
            trailing: Column(
              children: [
                CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: FittedBox(
                      child: Text('\$${cartItem.price}'),
                    ),
                  ),
                ),
                Text('${cartItem.quantity} x'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
