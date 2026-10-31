<%@ Page Title="Iniciar Sesión" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PARCIAL2_ASP.NET.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center py-4">
        <div class="col-lg-5 col-md-8">
            <div class="card card-tecno p-4 p-md-5 border-0 shadow">
                <div class="text-center mb-4">
                    <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-circle d-inline-block mb-3">
                        <i class="bi bi-shield-lock-fill fs-1"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Acceso al Sistema</h3>
                    <p class="text-muted small">Plataforma de Clientes y Vendedores - TecnoVigi Barranquilla</p>
                </div>

                <!-- Avisos de sesión / advertencias -->
                <asp:Panel ID="pnlAviso" runat="server" Visible="false" CssClass="alert alert-warning small">
                    <i class="bi bi-exclamation-triangle-fill me-1"></i>
                    <strong>Atención:</strong> Para realizar pedidos y compras en línea debe iniciar sesión como cliente registrado.
                </asp:Panel>

                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger small">
                    <i class="bi bi-x-circle-fill me-1"></i>
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </asp:Panel>

                <div class="mb-3">
                    <label class="form-label fw-bold small">Nombre de Usuario:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Ingrese su usuario"></asp:TextBox>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold small">Contraseña:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-key"></i></span>
                        <asp:TextBox ID="txtClave" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña"></asp:TextBox>
                    </div>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Ingresar al Sistema" CssClass="btn btn-primary w-100 fw-bold py-2 shadow-sm mb-3" OnClick="btnLogin_Click" />

                <div class="text-center border-top pt-3">
                    <p class="small text-muted mb-2">¿Eres un cliente nuevo en Parque Central?</p>
                    <a href="Registro.aspx" class="btn btn-outline-success btn-sm fw-bold">
                        <i class="bi bi-person-plus-fill me-1"></i>Crear Nueva Cuenta de Cliente
                    </a>
                </div>
            </div>

            <!-- Caja de ayuda con cuentas de prueba para el evaluador -->
            <div class="card p-3 mt-4 border-0 bg-light rounded-3 shadow-sm">
                <h6 class="fw-bold text-dark mb-2 small"><i class="bi bi-info-circle-fill text-info me-1"></i>Cuentas registradas para prueba docente:</h6>
                <div class="row g-2 small text-muted">
                    <div class="col-6">
                        <strong>🛡️ Administrador:</strong><br />
                        Usuario: <code class="text-dark">admin</code><br />
                        Clave: <code class="text-dark">admin123</code>
                    </div>
                    <div class="col-6">
                        <strong>👤 Cliente:</strong><br />
                        Usuario: <code class="text-dark">mgomez</code><br />
                        Clave: <code class="text-dark">cliente123</code>
                    </div>
                    <div class="col-12 mt-2 pt-2 border-top">
                        <strong>💼 Vendedor:</strong> Usuario: <code class="text-dark">cperez</code> | Clave: <code class="text-dark">ventas123</code>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
