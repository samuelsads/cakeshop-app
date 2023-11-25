import 'package:cakeshopapp/config/theme/boxdecoration_custom.dart';
import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/config/theme/margins.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:cakeshopapp/presentation/viewmodels/viewmodel_client.dart';
import 'package:cakeshopapp/presentation/widgets/global/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class ClienteNewPage extends StatefulWidget {
  const ClienteNewPage({this.update = false, this.clientUpd, super.key});
  final bool? update;
  final Client? clientUpd;
  @override
  State<ClienteNewPage> createState() => _ClienteNewPageState();
}

late TextEditingController name;
late TextEditingController fatherSurname;
late TextEditingController motherSurname;

class _ClienteNewPageState extends State<ClienteNewPage> {
  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    name = TextEditingController();
    fatherSurname = TextEditingController();
    motherSurname = TextEditingController();
    updateClient();
  }

  @override
  void dispose() {
    name.dispose();
    fatherSurname.dispose();
    motherSurname.dispose();
    super.dispose();
  }

  void updateClient() {
    if (widget.update!) {
      name.text = widget.clientUpd?.name ?? "";
      fatherSurname.text = widget.clientUpd?.fatherSurname ?? "";
      motherSurname.text = widget.clientUpd?.motherSurname ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxdecorationCustom.customBoxdecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24, top: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: const Icon(Icons.arrow_back)),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    (widget.update ?? false)
                        ? "Actualizar cliente"
                        : "Agregar cliente",
                    style: CustomStyles.text20W500(context
                        .select((ColorProvider value) => value.textColor)),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: CustomTextFormField(
                    controller: name,
                    title: "Nombre",
                    hint: "Nombre",
                    leftMargin: Margins.MARGIN_LEFT,
                    rightMargin: Margins.MARING_RIGHT,
                    width: MediaQuery.of(context).size.width),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: CustomTextFormField(
                    controller: fatherSurname,
                    title: "Apellido Paterno",
                    hint: "Apellido Paterno",
                    leftMargin: Margins.MARGIN_LEFT,
                    rightMargin: Margins.MARING_RIGHT,
                    width: MediaQuery.of(context).size.width),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: CustomTextFormField(
                    controller: motherSurname,
                    title: "Apellido Materno",
                    hint: "Apellido Materno",
                    leftMargin: Margins.MARGIN_LEFT,
                    rightMargin: Margins.MARING_RIGHT,
                    width: MediaQuery.of(context).size.width),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Margins.MARGIN_LEFT,
                    right: Margins.MARING_RIGHT,
                    top: 24),
                child: ElevatedButton(
                    onPressed: () async {
                      if (name.text.isEmpty && fatherSurname.text.isEmpty) {
                        Toast.show(
                            "Campos vacios, asegurese haber llenado todos los campos.",
                            duration: Toast.lengthLong,
                            gravity: Toast.bottom);
                        return;
                      }
                      Map<String, dynamic> data = {
                        "name": name.text,
                        "father_surname": fatherSurname.text,
                        "mother_surname": motherSurname.text
                      };
                      Save response;
                      if (widget.update ?? false) {
                        data["uid"] = widget.clientUpd!.uid;
                        response = await ViewmodelClient().saveOrder(
                            data, BlocProvider.of<ClientBloc>(context), true);
                      } else {
                        response = await ViewmodelClient().saveOrder(
                            data, BlocProvider.of<ClientBloc>(context), false);
                      }

                      Toast.show(response.msg,
                          duration: Toast.lengthLong, gravity: Toast.bottom);
                      if (widget.update ?? false) {
                        if (mounted) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      } else {
                        if (mounted) Navigator.pop(context);
                      }

                      return;
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: context
                            .select((ColorProvider value) => value.buttonColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save,
                            color: context.select((ColorProvider value) =>
                                value.textButtonColor)),
                        Text(
                          (widget.update ?? false)
                              ? "Actualizar cliente"
                              : "Guardar cliente",
                          style: TextStyle(
                              color: context.select((ColorProvider value) =>
                                  value.textButtonColor)),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
