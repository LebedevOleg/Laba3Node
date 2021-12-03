import axios from "axios";
import React, {
  useState,
  useEffect,
  useCallback,
  useContext,
  Component,
} from "react";
import fs, { writeFileSync } from "fs";
import { useHistory } from "react-router";
import { AuthContext } from "../context/authContext";
import { DatePickerComponent } from "@syncfusion/ej2-react-calendars";
import Dropdown from "react-dropdown";
import "react-dropdown/style.css";
let xlsx = require("json-as-xlsx");

var json2xls = require("json2xls");

const Buffer = require("buffer").Buffer;

const { Parser, parse } = require("json2csv");

export const Import = () => {
  const [dateStart, setDateStart] = useState(new Date());
  const [dateEnd, setDateEnd] = useState(new Date());
  const [value, setValue] = useState(0);
  const [formatDate, setFormatDate] = useState("");
  const [formatCount, setFormatCount] = useState("");
  const history = useHistory();
  const auth = useContext(AuthContext);
  const [upDown, setUpDown] = useState(false);
  const LogoutHandler = (event) => {
    event.preventDefault();
    auth.logout();
    history.push("/");
  };

  const options = [
    { value: 1, label: "1" },
    { value: 5, label: "5" },
    { value: 10, label: "10" },
  ];
  const handleChangeCount = (event) => {
    setValue(event.value);
  };
  const handleChangeDateStart = (event) => {
    setDateStart(event.value);
  };
  const handleChangeDateEnd = (event) => {
    setDateEnd(event.value);
  };

  function download(filename, text, type, charset = "utf-8") {
    var element = document.createElement("a");
    element.setAttribute(
      "href",
      `data:text/${type};charset=${charset},` + encodeURI(text)
    );
    element.setAttribute("download", filename);

    element.style.display = "none";
    document.body.appendChild(element);

    element.click();

    document.body.removeChild(element);
  }

  function downloadDOP(file, filename) {
    const blob = new Blob([file]);
    const fileDownloadUrl = URL.createObjectURL(blob);

    var element = document.createElement("a");
    element.setAttribute("href", fileDownloadUrl);
    element.setAttribute("download", filename);

    element.style.display = "none";
    document.body.appendChild(element);

    element.click();

    document.body.removeChild(element);
  }
  // *!! здесь функция отправки
  const ImportFileDate = async () => {
    var writeFile = [];
    var login = "";
    dateEnd.setDate(dateEnd.getDate() + 2);
    await axios
      .post("/api/forum/importDataDate", {
        StartDate: dateStart.toISOString().split("T")[0],
        EndDate: dateEnd.toISOString().split("T")[0],
      })
      .then(async (res) => {
        res.data.rows.map((row) => {
          if (row.login == null) {
            login = "[DELETED]";
          } else {
            login = row.login;
          }
          writeFile.push({
            id: row.id,
            login: login,
            text: row.text.replaceAll("\n", ""),
            date: row.date,
          });
        });
        var FileName = Date.now().toString() + "." + formatDate;
        switch (formatDate) {
          // !! УРА ОНО РАБОТАЕТ БЛЯТЬ!!!!!!! день на это дерьмо ушло!! !!!!!!!!!!!!!!!!!!!!!!
          case "json":
            var text =
              '{"messages":[' +
              writeFile
                .map(
                  ({ login, text, date }) =>
                    `{\"Пользователь\" : \"${login}\", \"текст\" :\"${text}\", \"дата\" :\"${date}\"}`,
                  ""
                )
                .join(",") +
              "]}";
            download(FileName, text, "json");
            break;
          case "xml":
            text =
              '<?xml version="1.0" encoding="utf-8"?> \n <forumPosts>' +
              writeFile
                .map(
                  ({ id, login, text, date }) =>
                    `<post category = "${id}">\n <author> ${login}</author> \n <content> ${text.replaceAll(
                      "<",
                      ""
                    )}</content> \n <date> ${date} </date>\n </post>`,
                  " "
                )
                .join("\n") +
              "</forumPosts>";
            download(FileName, text, "xml");
            break;
          // !! не меняется кодировка русские символы не читаемые Время 1:25 ДАЙТЕ МНЕ УМЕРЕТЬ
          case "csv":
            var fields = ["login", "text", "date"];
            var opts = {
              fields,
              delimiter: ";",
              header: true,
            };
            const csvFile = parse(writeFile, opts);
            download(
              FileName,
              writeFile
                .map(({ login, text, date }) => `${login};${text};${date}`)
                .join("\n"),
              "csv",
              "utf8"
            );
            break;
          case "xls":
            var data = {
              sheet: "messages",
              columns: [
                { label: "login", value: "login" },
                { label: "text", value: "text" },
                { label: "date", value: "date" },
              ],
              content: [],
            };

            writeFile.map(({ id, login, text, date }) => {
              data.content.push({
                login: login,
                text: text,
                date: date,
              });
            });
            var settings = { fileName: FileName, extraLength: 3 };
            xlsx(data, settings);
            //downloadDOP(text, FileName);
            break;
        }
        dateEnd.setDate(dateEnd.getDate());
      });
  };

  const ImportFileCount = async () => {
    console.log(formatCount);
    var writeFile = [];
    var login = "";
    if (upDown == false) {
      await axios
        .post("/api/forum/importDataCount", {
          Count: value,
          side: "desc",
        })
        .then(async (res) => {
          res.data.rows.map((row) => {
            if (row.login == null) {
              login = "[DELETED]";
            } else {
              login = row.login;
            }
            writeFile.push({
              id: row.id,
              login: login,
              text: row.text.replaceAll("\n", ""),
              date: row.date,
            });
          });
          var FileName = Date.now().toString() + "." + formatCount;
          switch (formatCount) {
            // !! УРА ОНО РАБОТАЕТ БЛЯТЬ!!!!!!! день на это дерьмо ушло!! !!!!!!!!!!!!!!!!!!!!!!
            case "json":
              var text =
                '{"messages":[' +
                writeFile
                  .map(
                    ({ login, text, date }) =>
                      `{\"Пользователь\" : \"${login}\", \"текст\" :\"${text}\", \"дата\" :\"${date}\"}`,
                    ""
                  )
                  .join(",") +
                "]}";
              download(FileName, text, "json");
              break;
            case "xml":
              text =
                '<?xml version="1.0" encoding="utf-8"?> \n <forumPosts>' +
                writeFile
                  .map(
                    ({ id, login, text, date }) =>
                      `<post category = "${id}">\n <author> ${login}</author> \n <content> ${text.replaceAll(
                        "<",
                        ""
                      )}</content> \n <date> ${date} </date>\n </post>`,
                    " "
                  )
                  .join("\n") +
                "</forumPosts>";
              download(FileName, text, "xml");
              break;
            // !! не меняется кодировка русские символы не читаемые Время 1:25 ДАЙТЕ МНЕ УМЕРЕТЬ
            case "csv":
              var fields = ["login", "text", "date"];
              var opts = {
                fields,
                delimiter: ";",
                header: true,
              };
              const csvFile = parse(writeFile, opts);
              download(FileName, csvFile, "csv", "utf8");
              break;
          }
        });
    } else {
      await axios
        .post("/api/forum/importDataCount", {
          Count: value,
          side: "asc",
        })
        .then(async (res) => {
          res.data.rows.map((row) => {
            if (row.login == null) {
              login = "[DELETED]";
            } else {
              login = row.login;
            }
            writeFile.push({
              id: row.id,
              login: login,
              text: row.text.replaceAll("\n", ""),
              date: row.date,
            });
          });
          var FileName = Date.now().toString() + "." + formatCount;
          switch (formatCount) {
            case "json":
              var text =
                '{"messages":[' +
                writeFile
                  .map(
                    ({ login, text, date }) =>
                      `{\"Пользователь\" : \"${login}\", \"текст\" :\"${text}\", \"дата\" :\"${date}\"}`,
                    ""
                  )
                  .join(",") +
                "]}";
              download(FileName, text, "json");
              break;
            case "xml":
              text =
                '<?xml version="1.0" encoding="utf-8"?> \n <forumPosts>' +
                writeFile
                  .map(
                    ({ id, login, text, date }) =>
                      `<post category = "${id}">\n <author> ${login}</author> \n <content> ${text.replaceAll(
                        "<",
                        ""
                      )}</content> \n <date> ${date} </date>\n </post>`,
                    " "
                  )
                  .join("\n") +
                "</forumPosts>";
              download(FileName, text, "xml");
              break;
            case "csv":
              var fields = ["login", "text", "date"];
              var opts = {
                fields,
                delimiter: ";",
                header: true,
              };
              const csvFile = parse(writeFile, opts);
              download(FileName, csvFile, "csv", "utf8");
              break;
          }
        });
    }
  };

  const handleChangeFormat = (event) => {
    if (event.target.name === "group1") {
      switch (event.target.id) {
        case "1":
          setFormatDate("json");
          break;
        case "2":
          setFormatDate("csv");
          break;
        case "3":
          setFormatDate("xml");
          break;
        case "4":
          setFormatDate("xls");
          break;
      }
    } else {
      switch (event.target.id) {
        case "1":
          setFormatCount("json");
          break;
        case "2":
          setFormatCount("csv");
          break;
        case "3":
          setFormatCount("xml");
          break;
        case "4":
          setFormatDate("xls");
          break;
      }
    }
  };

  const changeBlockHandler = async (event) => {
    setUpDown(event.target.checked);
  };

  return (
    <>
      <nav>
        <div className="nav-wrapper #689f38 light-green darken-2">
          <a className="brand-logo ">Страница форума</a>
          <ul id="nav-mobile" className="right hide-on-med-and-down ">
            <li> Пользователь: {auth.userLogin}</li>
            <li>
              <a href="/forum/">Форум</a>{" "}
            </li>
            <li>
              <a href="/import/">импорт сообщений</a>{" "}
            </li>
            <li>
              <a href="/" onClick={LogoutHandler}>
                выход
              </a>
            </li>
          </ul>
        </div>
      </nav>
      <div className="row">
        <div className="col s12 m6 ">
          <div className="card blue-grey darken-1">
            <div className="card-content white-text">
              <span className="card-title">Импорт по дате</span>
              <div>
                Дата начала импорта
                <DatePickerComponent
                  placeholder="Дата начала импорта"
                  format="yyyy/MM/dd"
                  max={new Date(Date.now())}
                  onChange={handleChangeDateStart}
                ></DatePickerComponent>
                Дата конца импорта
                <DatePickerComponent
                  placeholder="Дата конца импорта"
                  format="yyyy/MM/dd"
                  max={new Date(Date.now())}
                  onChange={handleChangeDateEnd}
                ></DatePickerComponent>
                <p>
                  <form action="#">
                    <p>
                      <label>
                        <input
                          id="1"
                          name="group1"
                          type="radio"
                          onChange={handleChangeFormat}
                        />
                        <span>JSON</span>
                      </label>
                    </p>
                    <p>
                      <label>
                        <input
                          id="2"
                          name="group1"
                          type="radio"
                          onChange={handleChangeFormat}
                        />
                        <span>CSV </span>
                      </label>
                    </p>
                    <p>
                      <label>
                        <input
                          id="3"
                          class="with-gap"
                          name="group1"
                          type="radio"
                          onChange={handleChangeFormat}
                        />
                        <span>XML</span>
                      </label>
                    </p>
                    <p>
                      <label>
                        <input
                          id="4"
                          class="with-gap"
                          name="group1"
                          type="radio"
                          onChange={handleChangeFormat}
                        />
                        <span>DOCX</span>
                      </label>
                    </p>
                  </form>
                </p>
              </div>
            </div>
            <div className="card-action">
              <a style={{ cursor: "pointer" }} onClick={ImportFileDate}>
                Импортировать
              </a>
            </div>
          </div>
        </div>

        <div className="col s12 m6 ">
          <div className="card blue-grey darken-1">
            <div className="card-content white-text">
              <span className="card-title">Импорт по колличеству</span>
              <Dropdown
                options={options}
                onChange={handleChangeCount}
                value={value}
              />
              <p>
                <form action="#">
                  <p>
                    <label>
                      <input
                        id="1"
                        name="group2"
                        type="radio"
                        onChange={handleChangeFormat}
                      />
                      <span>JSON</span>
                    </label>
                  </p>
                  <p>
                    <label>
                      <input
                        id="2"
                        name="group2"
                        type="radio"
                        onChange={handleChangeFormat}
                      />
                      <span>CSV </span>
                    </label>
                  </p>
                  <p>
                    <label>
                      <input
                        id="3"
                        name="group2"
                        type="radio"
                        onChange={handleChangeFormat}
                      />
                      <span>XML</span>
                    </label>
                  </p>
                  <p>
                    <label>
                      <input
                        id="4"
                        name="group2"
                        type="radio"
                        onChange={handleChangeFormat}
                      />
                      <span>DOCX</span>
                    </label>
                  </p>
                </form>
              </p>
              <div className="switch">
                <label>
                  С верху
                  <input type="checkbox" onChange={changeBlockHandler} />
                  <span className="lever"></span>С низу
                </label>
              </div>
            </div>
            <div className="card-action">
              <a style={{ cursor: "pointer" }} onClick={ImportFileCount}>
                Импортировать
              </a>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Import;
