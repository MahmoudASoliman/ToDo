import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/tasks_cubit.dart';
import 'package:todo_app/widgets/bottom_sheet_items.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              TasksCubit.get(context)
                  .titles[TasksCubit.get(context).currentIndex],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  TasksCubit.get(context).changeThemeMode();
                },
                icon: const Icon(Icons.dark_mode),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: TasksCubit.get(context).currentIndex,
            onTap: (index) {
              TasksCubit.get(context).changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'tasks',
                activeIcon: Icon(
                  Icons.menu,
                  color: Colors.blue,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check),
                label: 'Done',
                activeIcon: Icon(
                  Icons.check,
                  color: Colors.blue,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archived',
                activeIcon: Icon(
                  Icons.archive,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showBottomSheetMethod(context);
            },
            backgroundColor: Colors.blue,
            child: Icon(
              TasksCubit.get(context).isOpenBottom ? Icons.edit : Icons.add,
              color: Colors.white,
            ),
          ),
          body: TasksCubit.get(context)
              .pages[TasksCubit.get(context).currentIndex],
        );
      },
    );
  }

  void showBottomSheetMethod(BuildContext context) {
    if (TasksCubit.get(context).isOpenBottom) {
      scaffoldKey.currentState
          ?.showBottomSheet(
            elevation: 22,
            (context) => Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: Form(
                key: formKey,
                child: BottomSheetItems(),
              ),
            ),
          )
          .closed
          .then((value) {
        TasksCubit.get(context).openBottom();
      });

      TasksCubit.get(context).closeBottom();
    } else {
      if (formKey.currentState!.validate()) {
        TasksCubit.get(context).insertToDatabase(
          title: TasksCubit.get(context).name.toString(),
          time: TasksCubit.get(context).time.toString(),
          date: TasksCubit.get(context).date.toString(),
        );
        Navigator.pop(context);
      }
    }
  }
}
