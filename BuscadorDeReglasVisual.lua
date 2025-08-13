-- Buscador visual de reglas de rol con todas las reglas y botón para cerrar/abrir

local reglas = {
    -- Puedes buscar por número, por palabra clave, o por contenido.
    -- El formato es ["clave"] = "Descripción"
    ["1.1.1"] = "IC (In Character): Información o acciones que pertenecen exclusivamente al personaje dentro del entorno del rol.",
    ["1.1.2"] = "OOC (Out Of Character): Información o acciones que provienen del jugador, ajenas al personaje.",
    ["1.1.3"] = "PJ (Personaje): Representación del jugador dentro del servidor, con historia, motivaciones y características únicas.",
    ["1.1.4"] = "ER (Evadir Rol): Acción de desconectarse, forzar un accidente u omitir la continuación de un rol para evitar sus consecuencias.",
    ["1.2.1"] = "DM (DeathMatch): Asesinar a otro jugador sin razón válida dentro del entorno de rol.",
    ["1.2.2"] = "RK (Revenge Kill): Regresar a una situación tras haber muerto, con el fin de vengarse del agresor.",
    ["1.2.3"] = "TK (Team Kill): Atacar o eliminar a un miembro de tu propia facción o grupo sin justificación de rol.",
    ["1.2.4"] = "FR (Forzar Rol): Obligar a otro jugador a aceptar una situación sin darle opción de decisión o reacción.",
    ["1.3.1"] = "MG (Metagaming): Usar información obtenida fuera de rol (OOC) para obtener ventaja dentro del juego (IC).",
    ["1.3.2"] = "PG (Powergaming): Realizar actos físicamente imposibles o ignorar las limitaciones del entorno o del personaje.",
    ["1.3.3"] = "MK (Meta Kill): Eliminar a un jugador por motivos personales ajenos al personaje y la narrativa del rol.",
    ["1.3.4"] = "BA (Bug Abuse): Usar fallos técnicos o errores del juego en beneficio propio o el de otros.",
    ["1.3.5"] = "LA (Lag Abuse): Aprovechar intencionalmente el lag para evitar daños o ganar ventaja injusta.",
    ["1.4.1"] = "NPVJ (No valorar la vida del personaje): Actuar de forma absurda sin tener en cuenta la supervivencia o bienestar del personaje.",
    ["1.4.2"] = "NRE (No rolear entorno): Es no enviar un mensaje de entorno en el canal correspondiente cuando haces una acción que lo necesita, como un robo o disparos. El entorno simula que un civil vio lo ocurrido y llamó a la policía.",
    ["1.4.3"] = "NRC (No rolear choque): No simular las consecuencias de un accidente vehicular, por mínimo que sea.",
    ["1.4.4"] = "NRH (No rolear Heridas): No representar el dolor o las lesiones tras recibir daño.",
    ["1.4.5"] = "NRA (No rolear arma): No hacer el rol correspondiente al momento de sacar un arma visible.",
    ["1.4.6"] = "ZZ (ZigZag): Correr de un lado a otro para esquivar balas durante un tiroteo, rompiendo el realismo.",
    ["1.4.7"] = "BD (Bad Driving): Conducir de forma antinatural o peligrosa sin justificación, afectando el desarrollo del rol.",
    ["1.5.1"] = "IOOC (Insultos OOC): Dirigir ofensas o comentarios hostiles fuera del personaje, afectando directamente al jugador.",
    ["1.5.2"] = "NA (Noob Abuse): Aprovecharse de jugadores nuevos mediante engaños, robos o asesinatos injustificados.",
    ["1.5.3"] = "AA (Admin Abuse): Uso injustificado de comandos administrativos con fines personales o parciales.",
    ["1.5.4"] = "KAD/KHD (Kill Admin/Helper Duty): Atacar o asesinar a un miembro del staff mientras se encuentra en servicio.",
    ["1.6.1"] = "CK (Character Kill): Muerte definitiva del personaje. Implica el fin de su historia y el borrado total de su identidad.",
    ["1.6.2"] = "PK (Player Kill): Muerte parcial del personaje que conlleva pérdida de memoria según contexto establecido por la normativa del servidor.",
    -- Continúa agregando reglas con el mismo formato...
    ["2.1.1"] = "Uso de vestimenta oficial: Los personajes deberán vestir de manera acorde al entorno, época y contexto del rol.",
    ["2.1.2"] = "Vestimenta coherente con el entorno: Prohibido ropa o estilos que contradigan la ambientación.",
    ["2.1.3"] = "Accesorios fantásticos o irreales: Prohibido portar elementos visuales que rompan el realismo.",
    ["2.1.4"] = "Accesorios tácticos o militares: Uso restringido a personal autorizado.",
    ["2.2.1"] = "Forma corporal: El cuerpo del personaje debe mantener el modelo base cuadrado.",
    ["2.2.2"] = "Rostro cubierto: Si el rostro está cubierto no podrá ser identificado visualmente y debe rolear la condición.",
    ["3.1.1"] = "Placa vehicular: Todo vehículo debe portar una placa con el formato establecido.",
    ["3.1.2"] = "Vehículos oficiales: Prohibido el uso o robo de vehículos destinados a funciones oficiales por parte de civiles.",
    ["3.2.1"] = "Vehículos eléctricos: Limitado a usuarios booster plus o sponsor plus.",
    ["3.2.2"] = "Vehículos 4x4: Solo vehículos con tracción 4x4 pueden acceder a terrenos irregulares o colinas.",
    ["3.2.3"] = "Robos de vehículos: Sólo autos de menos de $25.000 pueden robarse sin pase de autos, con rol y entorno obligatorio.",
    ["3.3.1"] = "Neumáticos pinchados: El auto debe detenerse en 5 segundos tras pinchar la llanta.",
    ["3.3.2"] = "Blindaje del vehículo: Solo se puede rolear blindaje si se ha adquirido dentro del servidor.",
    ["3.4.1"] = "Uso de vehículos sin permiso: Conducir sin pase válido será sancionado, salvo autos < $25,000 con rol y entorno.",
    ["3.4.2"] = "Clasificación de permisos: Normal: hasta $50,000; Premium: hasta $150,000; Exótico: cualquier auto.",
    ["3.4.3"] = "Sanción por incumplimiento: Retiro del vehículo y sanción, reincidencia implica pérdida definitiva del pase.",
    ["4.1.1"] = "Violencia sexual o acoso: Prohibido roles relacionados con violaciones, abuso sexual o acoso. Baneo permanente.",
    ["4.1.2"] = "Autolesiones o suicidio: Prohibido rolear suicidio, autolesiones o automutilación.",
    ["4.2.1"] = "Intervención de EMS en zonas peligrosas: EMS no puede ingresar donde haya disparos o peligro activo.",
    ["4.2.2"] = "Respuestas ante el comando /do: Prohibido mentir con /do, respuestas veraces y coherentes.",
    ["4.2.3"] = "Comunicación en estado de inconsciencia: No se puede transmitir información en estado inconsciente.",
    ["4.2.4"] = "Realismo en el rol de choques: Obligatorio rolear consecuencias físicas y emocionales de accidentes.",
    ["4.2.5"] = "Respawn por ausencia de EMS: Se puede respawnear después de 3 minutos si no hay EMS.",
    ["4.2.6"] = "Rol de chaleco: Solo válido si se adquirió en el sistema, solo protege con pistolas.",
    -- ...sigue agregando el resto de los artículos y reglas con el mismo formato...
    -- Agrega tantas reglas como desees, incluso textos largos
}

-- Función buscador (varias coincidencias)
local function buscarPorPalabra(palabra)
    palabra = string.lower(palabra)
    local resultados = {}
    for num, texto in pairs(reglas) do
        if string.find(string.lower(texto), palabra) or string.find(string.lower(num), palabra) then
            table.insert(resultados, "[" .. num .. "] " .. texto)
        end
    end
    if #resultados == 0 then
        return "No se encontró ninguna regla con esa palabra clave."
    else
        return table.concat(resultados, "\n\n")
    end
end

local cuadroAbierto = true

local gui = Instance.new("ScreenGui")
gui.Name = "BuscadorDeReglasApartado"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Position = UDim2.new(0.5, -180, 0.5, -120)
frame.Size = UDim2.new(0, 360, 0, 240)
frame.BackgroundColor3 = Color3.fromRGB(245,245,245)
frame.BackgroundTransparency = 0.08
frame.BorderSizePixel = 0

local titulo = Instance.new("TextLabel")
titulo.Parent = frame
titulo.Size = UDim2.new(1, 0, 0, 40)
titulo.Position = UDim2.new(0, 0, 0, 0)
titulo.Text = "Buscador por Palabra Clave"
titulo.Font = Enum.Font.GothamBold
titulo.TextColor3 = Color3.fromRGB(40, 40, 40)
titulo.BackgroundTransparency = 1
titulo.TextScaled = true

local inputBox = Instance.new("TextBox")
inputBox.Parent = frame
inputBox.Size = UDim2.new(0.9, 0, 0, 32)
inputBox.Position = UDim2.new(0.05, 0, 0, 50)
inputBox.PlaceholderText = "Escribe la palabra clave aquí..."
inputBox.Font = Enum.Font.Gotham
inputBox.TextColor3 = Color3.fromRGB(40, 40, 40)
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
inputBox.BackgroundTransparency = 0.05
inputBox.BorderSizePixel = 0
inputBox.TextScaled = true

local buscarBtn = Instance.new("TextButton")
buscarBtn.Parent = frame
buscarBtn.Size = UDim2.new(0.4, 0, 0, 32)
buscarBtn.Position = UDim2.new(0.3, 0, 0, 90)
buscarBtn.Text = "Buscar"
buscarBtn.Font = Enum.Font.GothamBold
buscarBtn.TextColor3 = Color3.fromRGB(255,255,255)
buscarBtn.BackgroundColor3 = Color3.fromRGB(60,120,255)
buscarBtn.BackgroundTransparency = 0.05
buscarBtn.BorderSizePixel = 0
buscarBtn.TextScaled = true

local resultadoLabel = Instance.new("TextLabel")
resultadoLabel.Parent = frame
resultadoLabel.Size = UDim2.new(0.9, 0, 0, 80)
resultadoLabel.Position = UDim2.new(0.05, 0, 0, 140)
resultadoLabel.BackgroundTransparency = 0.2
resultadoLabel.BackgroundColor3 = Color3.fromRGB(220, 223, 236)
resultadoLabel.BorderSizePixel = 0
resultadoLabel.Text = ""
resultadoLabel.Font = Enum.Font.Gotham
resultadoLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
resultadoLabel.TextScaled = true
resultadoLabel.TextWrapped = true

local cerrarBtn = Instance.new("TextButton")
cerrarBtn.Parent = frame
cerrarBtn.Size = UDim2.new(0, 36, 0, 36)
cerrarBtn.Position = UDim2.new(1, -40, 0, 4)
cerrarBtn.Text = "✕"
cerrarBtn.Font = Enum.Font.GothamBold
cerrarBtn.TextColor3 = Color3.fromRGB(255,70,70)
cerrarBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
cerrarBtn.BackgroundTransparency = 0.6
cerrarBtn.BorderSizePixel = 0
cerrarBtn.TextScaled = true

local abrirBtn = Instance.new("TextButton")
abrirBtn.Parent = gui
abrirBtn.Size = UDim2.new(0, 50, 0, 40)
abrirBtn.Position = UDim2.new(0, 12, 0, 12)
abrirBtn.Text = "🔍"
abrirBtn.Font = Enum.Font.GothamBold
abrirBtn.TextColor3 = Color3.fromRGB(60,120,255)
abrirBtn.BackgroundColor3 = Color3.fromRGB(245,245,245)
abrirBtn.BackgroundTransparency = 0.2
abrirBtn.BorderSizePixel = 0
abrirBtn.TextScaled = true
abrirBtn.Visible = false

buscarBtn.MouseButton1Click:Connect(function()
    resultadoLabel.Text = buscarPorPalabra(inputBox.Text)
end)
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        resultadoLabel.Text = buscarPorPalabra(inputBox.Text)
    end
end)

cerrarBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    abrirBtn.Visible = true
    cuadroAbierto = false
end)
abrirBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    abrirBtn.Visible = false
    cuadroAbierto = true
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F9 then
        cuadroAbierto = not cuadroAbierto
        frame.Visible = cuadroAbierto
        abrirBtn.Visible = not cuadroAbierto
    end
end)
