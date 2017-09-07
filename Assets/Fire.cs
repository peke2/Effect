using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fire : MonoBehaviour {

    Vector4 offset;
    Vector3 scale;
    float angle;

    Light targetLight;
    float lightParam;
    Color baseColor;


	// Use this for initialization
	void Start () {
        scale = new Vector3(1, 1, 1);
        angle = 0;

        targetLight = GameObject.Find("FireLight").GetComponent<Light>();
        lightParam = 0f;
        baseColor = targetLight.color;
    }
	
	// Update is called once per frame
	void Update () {
        Material mat = GetComponent<Renderer>().material;
        mat.SetVector("_UvOffset", offset);

        offset.y -= 0.02f;
        //offset.x = Mathf.Sin(Mathf.Deg2Rad * angle) * 0.3f;

        float vib = 0;
        //vib = Random.Range(-0.01f, 0.01f);
        scale.x = -Mathf.Sin(Mathf.Deg2Rad * angle)*0.1f + vib + 0.8f;
        //vib = Random.Range(-0.01f, 0.01f);
        //scale.y = Mathf.Sin(Mathf.Deg2Rad * angle)*0.01f + vib + 1.0f;

        transform.localScale = scale;

        vib = Random.Range(0.0f, 1.0f);

        angle += 0.5f + vib;
        if (angle > 180.0f) angle -= 180.0f;

        float power;
        power = Mathf.Sin(Mathf.Deg2Rad * lightParam) * 0.1f;
        Color col = new Color(baseColor.r + power, baseColor.g + power, baseColor.b + power, baseColor.a);
        targetLight.color = col;
        lightParam += 10f;
        if (lightParam > 180.0f) lightParam -= 180.0f;
    }
}
