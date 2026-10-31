<%@ Page Title="Registro de Cliente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="PARCIAL2_ASP.NET.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center py-4">
        <div class="col-lg-7 col-md-9">
            <div class="card card-tecno p-4 p-md-5 border-0 shadow">
                <div class="text-center mb-4">
                    <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle d-inline-block mb-3">
                        <i class="bi bi-person-plus-fill fs-1"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Registro de Nuevo Cliente</h3>
                    <p class="text-muted small">Crea tu cuenta para realizar pedidos y compras de tecnología y seguridad en Parque Central</p>
                </div>

                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger small">
                    <i class="bi bi-x-circle-fill me-1"></i>
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </asp:Panel>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Documento de Identidad / C.C.: <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtDocumento" runat="server" CssClass="form-control" placeholder="Ej: 1045234567" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Nombre y Apellidos Completos: <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Andrés Morales" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Teléfono / Celular:</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 301 987 6543"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Correo Electrónico:</label>
                        <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" CssClass="form-control" placeholder="nombre@correo.com"></asp:TextBox>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-bold small">Dirección de Entrega / Domicilio en Barranquilla:</label>
                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Ej: Cra 45 # 54-20, Barrio Parque Central"></asp:TextBox>
                    </div>

                    <div class="col-12"><hr class="my-2" /></div>

                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Nombre de Usuario para Acceso: <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Elija su nombre de usuario" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Contraseña: <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtClave" runat="server" TextMode="Password" CssClass="form-control" placeholder="Cree una contraseña segura" required="true"></asp:TextBox>
                    </div>

                    <div class="col-12 mt-4">
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar Mi Cuenta de Cliente" CssClass="btn btn-success w-100 fw-bold py-2 shadow-sm" OnClick="btnRegistrar_Click" />
                    </div>
                </div>

                <div class="text-center mt-4 pt-3 border-top">
                    <span class="small text-muted">¿Ya tienes una cuenta registrada? </span>
                    <a href="Login.aspx" class="small fw-bold text-primary">Inicia Sesión Aquí</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
